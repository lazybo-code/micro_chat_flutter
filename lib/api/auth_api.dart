import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/tools/dio/result_data.dart';
import 'package:micro_chat/tools/request_tool.dart';

class AuthApi {
  /// 用户登录
  static Future<ResultData> userLogin({
    String username,
    String password,
    String type = 'app',
  }) async {
    return await RequestTool.getInstance().post('/auth/user/login', {
      'username': username,
      'password': password,
      'type': type,
    });
  }

  /// 用户注册
  static Future<ResultData> userRegister({
    String nickname,
    String username,
    String password
  }) async {
    return await RequestTool.getInstance().post('/auth/user/register', {
      'nickname': nickname,
      'username': username,
      'password': password,
    });
  }

  /// 读取用户数据
  static Future<ResultData> userProfile() async {
    return await RequestTool.getInstance().get('/auth/user/profile');
  }
}
