import 'package:dio/dio.dart';

class LogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async{
    print("\n================== 请求数据 ==========================");
    print("url = ${options.uri.toString()}");
    print("headers = ${options.headers}");
    print("params = ${options.data}");
    return options;
  }

  @override
  onResponse(Response response)async {
    if (response != null) {
      print("\n================== 响应数据 ==========================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print("\n");
    }
    return response; // continue
  }

  @override
  onError(DioError err) async{
    print("\n================== 错误响应数据 ======================");
    print("type = ${err.type}");
    print("message = ${err.message}");
    print("data = ${err.response?.data?.toString()}");
    print("\n");
    return err;
  }
}