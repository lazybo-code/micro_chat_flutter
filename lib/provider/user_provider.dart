import 'package:flutter/foundation.dart';
import 'package:micro_chat/api/auth_api.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/tools/dio/result_data.dart';
import 'package:micro_chat/tools/preference_tool.dart';
import 'package:micro_chat/types/user_login_result.dart';
import 'package:micro_chat/types/user_profile_result.dart';

class UserProvider with ChangeNotifier {
  UserLoginResult _userLoginResult = UserLoginResult();
  UserLoginResult get userLoginResult => _userLoginResult;

  UserProfileResult _userProfileResult = UserProfileResult();
  UserProfileResult get userProfileResult => _userProfileResult;

  Future<bool> userLogin({
    String username,
    String password,
    String type = 'app',
  }) async {
    ResultData res = await AuthApi.userLogin(username: username, password: password, type: type);
    if (res.isSuccess) {
      _userLoginResult = UserLoginResult.fromJson(res.data);
      await PreferenceTool.saveData('Authorization', _userLoginResult.access_token);
      await PreferenceTool.saveData('RefreshToken', _userLoginResult.refresh_token);
    } else {
      BasisTool.showToast(message: res.data['message'].toString());
    }
    notifyListeners();
    return res.isSuccess;
  }

  Future<bool> userProfile() async {
    ResultData res = await AuthApi.userProfile();
    if (res.isSuccess) {
      _userProfileResult = UserProfileResult.fromJson(res.data);
    }
    notifyListeners();
    return res.isSuccess;
  }
}
