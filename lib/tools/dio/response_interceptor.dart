import 'package:dio/dio.dart';
import 'result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    try {
      if (option.contentType != null && option.contentType.contains("text")) {
        return new ResultData(response.data, true, 200);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new ResultData(
          response.data,
          true,
          200,
          headers: response.headers,
        );
      }
    } catch (e) {
      return new ResultData(
        response.data,
        false,
        response.statusCode,
        headers: response.headers,
      );
    }

    return new ResultData(
      response.data,
      false,
      response.statusCode,
      headers: response.headers,
    );
  }
}
