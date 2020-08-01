import 'package:micro_chat/tools/dio/result_data.dart';
import 'package:micro_chat/tools/request_tool.dart';

class MessageApi {
  /// 读取联系人消息列表
  static Future<ResultData> getMessageFriends() async {
    return await RequestTool.getInstance().get('/message/friends');
  }

  /// 读取消息记录
  static Future<ResultData> getMessage({
    String friendId,
    int page = 1,
    int limit = 30,
  }) async {
    return await RequestTool.getInstance().get(
      '/message',
      params: {'friendId': friendId, 'page': page, 'limit': limit},
    );
  }

  /// 发送文本消息
  static Future<ResultData> sendTextMessage({
    String friendId,
    String text,
  }) async {
    return await RequestTool.getInstance().post(
      '/message/text',
      {
        'friendId': friendId,
        'text': text,
      },
    );
  }
}
