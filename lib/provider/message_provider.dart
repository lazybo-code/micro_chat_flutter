import 'package:flutter/foundation.dart';
import 'package:micro_chat/api/message_api.dart';
import 'package:micro_chat/tools/dio/result_data.dart';
import 'package:micro_chat/types/message_friends_result.dart' as M;
import 'package:micro_chat/types/message_news_result.dart' as Mn;

class MessageProvider with ChangeNotifier {
  List<M.MessageFriendsResult> _messageFriendsResult = [];
  List<M.MessageFriendsResult> get messageFriendsResult => _messageFriendsResult;

  List<Mn.MessageNewsResult> _messageNewResult = [];
  List<Mn.MessageNewsResult> get messageNewResult => _messageNewResult;

  String _friendId;

  Future loadMessageFriends({ bool isLoad = false }) async {
    if (_messageFriendsResult.length > 0 && isLoad == false) return;
    ResultData res = await MessageApi.getMessageFriends();
    if (res.isSuccess) {
      _messageFriendsResult.clear();
      res.data.forEach((data) {
        _messageFriendsResult.add(M.MessageFriendsResult.fromJson(data));
      });
      notifyListeners();
    }
  }

  Future loadMessage(String friendId, {int page = 1, int limit = 30, bool load = false}) async {
    ResultData res = await MessageApi.getMessage(friendId: friendId, page: page, limit: limit);
    if (res.isSuccess) {
      if (_friendId != friendId || load == true) {
        _messageNewResult.clear();
        _friendId = friendId;
      }
      res.data.forEach((data) {
        _messageNewResult.add(Mn.MessageNewsResult.fromJson(data));
      });
      notifyListeners();
    }
  }

  Future<ResultData> sendTextMessage(String friendId, String text) async {
    ResultData res = await MessageApi.sendTextMessage(friendId: friendId, text: text);
    if (res.isSuccess) {
      this.setMessageFriend(res.data['userId'], res.data['friendId'], res.data);
      _messageNewResult.insert(0, Mn.MessageNewsResult.fromJson(res.data));
    }
    notifyListeners();
    return res;
  }

  setTextMessage(Map<String, dynamic> json) {
    _messageNewResult.insert(0, Mn.MessageNewsResult.fromJson(json));
    notifyListeners();
  }

  setMessageFriend(int userId, int friendId, Map<String, dynamic> json) {
    int index = _messageFriendsResult.indexWhere((friend) => friend.userId == userId && friend.friendId == friendId);
    if (index != -1) {
      if (json['user'] == null) {
        json['user'] = _messageFriendsResult[index].user.toJson();
        if (_messageFriendsResult[index].count != null) {
          json['count'] = _messageFriendsResult[index].count + 1;
        } else {
          json['count'] = 1;
        }
      }
      _messageFriendsResult[index] = M.MessageFriendsResult.fromJson(json);
      notifyListeners();
    } else {
      this.loadMessageFriends(isLoad: true);
    }
  }

}