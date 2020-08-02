import 'package:flutter/foundation.dart';
import 'package:micro_chat/api/friends_api.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/tools/dio/result_data.dart';
import 'package:micro_chat/types/friends_list_result.dart';
import 'package:micro_chat/types/query_friends_result.dart';

class FriendsProvider with ChangeNotifier {
  Map<String, dynamic> _friends = {};
  Map<String, dynamic> get friends => _friends;

  List<FriendsListItemResult> _friendsApply = [];
  List<FriendsListItemResult> get friendsApply => _friendsApply;

  List<QueryFriendsResult> _queryFriends = [];
  List<QueryFriendsResult> get queryFriends => _queryFriends;

  Future<bool> getFriends({ isLoad: false }) async {
    if (_friends.keys.length > 0 && isLoad == false) {
      return true;
    }
    ResultData res = await FriendsApi.getFriends();
    if (res.isSuccess) _friends = res.data;
    notifyListeners();
    return res.isSuccess;
  }

  Future getFriendsApply() async {
    ResultData res = await FriendsApi.getFriendsApply();
    if (res.isSuccess) {
      _friendsApply = (res.data as List<dynamic>).map((e) => FriendsListItemResult.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<bool> putApplyStatus(String friendId, String status, { String refusal }) async {
    ResultData res = await FriendsApi.putApplyStatus(friendId, status, refusal: refusal);
    if (res.isSuccess) {
      await this.getFriendsApply();
      await this.getFriends(isLoad: true);
    } else {
      BasisTool.showToast(message: res.data['message'].toString());
    }
    return res.isSuccess;
  }

  Future getQueryFriends(String query) async {
    ResultData res = await FriendsApi.queryFriends(query);
    if(res.isSuccess) {
      _queryFriends = (res.data as List<dynamic>).map((e) => QueryFriendsResult.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<bool> addFriend(String query, int friendId, String description, { String remark }) async {
    ResultData res = await FriendsApi.addFriend(friendId, description, remark: remark);
    if(res.isSuccess == false) {
      BasisTool.showToast(message: res.data['message'].toString());
    }
    await getQueryFriends(query);
    notifyListeners();
    return res.isSuccess;
  }
}