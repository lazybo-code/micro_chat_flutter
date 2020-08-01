import 'package:dio/dio.dart';
import 'package:micro_chat/event/result_error_event.dart';
import 'package:micro_chat/tools/preference_tool.dart';
import 'basis_tool.dart';
import 'dio/code.dart';
import 'dio/logs_interceptors.dart';
import 'dio/response_interceptor.dart';
import 'dio/result_data.dart';

class RequestTool {
  static RequestTool _instance = RequestTool._internal();
  Dio _dio;

  RequestTool._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = Dio(
        BaseOptions(
          baseUrl: BasisTool.BASE_URL,
          connectTimeout: 15000,
        ),
      );
      _dio.interceptors.add(LogsInterceptors());
      _dio.interceptors.add(ResponseInterceptors());
    }
  }

  static RequestTool getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名，比如cdn和kline首次的http请求
  RequestTool _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  RequestTool _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != BasisTool.BASE_URL) {
        _dio.options.baseUrl = BasisTool.BASE_URL;
      }
    }
    return this;
  }

  auth() async {
    String token = await PreferenceTool.loadData('Authorization');
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  ///通用的GET请求
  get(api, {noTip = false, Map<String, dynamic> params}) async {
    Response response;
    try {
      await auth();
      response = await _dio.get(api, queryParameters: params);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data['code']);
    }
    return response.data;
  }

  ///通用的POST请求
  post(api, params, {noTip = false}) async {
    Response response;
    try {
      await auth();
      response = await _dio.post(api, data: params);
    } on DioError catch (e) {
      print("err => ${e.response.data.toString()}");
      return resultError(e);
    }
    if (response.data is DioError) {
      print("err => ${response.data.toString()}");
      return resultError(response.data);
    }
    return response.data;
  }

  /// 通用的put请求
  put(api, params, {noTip = false}) async {
    Response response;
    try {
      await auth();
      response = await _dio.put(api, data: params);
    } on DioError catch (e) {
      print("err => ${e.response.data.toString()}");
      return resultError(e);
    }
    if (response.data is DioError) {
      print("err => ${response.data.toString()}");
      return resultError(response.data);
    }
    return response.data;
  }
}

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response.statusCode == 401) {
    // 登录过期, 发起重新登录的请求
    resultErrorEventBus.fire(AuthErrorEvent(401, e.response.data['message']));
  }
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = Response(statusCode: 666);
  }
  if (e.type == DioErrorType.CONNECT_TIMEOUT ||
      e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  }
  return ResultData(
    errorResponse.data,
    false,
    errorResponse.statusCode,
  );
}
