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
  static Future<bool> userRegister({
    String nickname,
    String username,
    String password,
    String passwordNew,
  }) async {
    if (password != passwordNew) {
      BasisTool.showToast(message: "两次输入的密码不一致");
    }
    ResultData res = await RequestTool.getInstance().post('/auth/user/register', {
      'nickname': nickname,
      'username': username,
      'password': password,
    });
    if (res.isSuccess) return true;
    BasisTool.showToast(message: res.data['message']);
    return false;
  }

  /// 读取用户数据
  static Future<ResultData> userProfile() async {
    return await RequestTool.getInstance().get('/auth/user/profile');
  }
}
