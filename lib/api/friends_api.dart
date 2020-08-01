import 'package:micro_chat/tools/dio/result_data.dart';
import 'package:micro_chat/tools/request_tool.dart';

class FriendsApi {
  /// 读取好友列表数据
  static Future<ResultData> getFriends() async {
    return await RequestTool.getInstance().get('/friends');
  }

  /// 读取申请列表
  static Future<ResultData> getFriendsApply() async {
    return await RequestTool.getInstance().get('/friends/apply');
  }

  /// 更改申请状态
  static Future<ResultData> putApplyStatus(String friendId, String status, { String refusal }) async {
    Map<String, dynamic> data = {
      'friendId': friendId,
      'status': status,
    };
    if (refusal != null) {
      data['refusal'] = refusal;
    }
    return await RequestTool.getInstance().put('/friends/status', data);
  }
}