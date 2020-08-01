import 'package:flutter/material.dart';
import 'package:micro_chat/types/message_friends_result.dart' as M;
import 'package:micro_chat/components/friend_head_info.dart';
import 'package:micro_chat/components/menu_list.dart';
import 'package:micro_chat/icon/chat_icon.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/types/friends_list_result.dart';

class FriendDetailsPage extends StatefulWidget {
  FriendDetailsPage({Key key}) : super(key: key);

  @override
  _FriendDetailsPageState createState() => _FriendDetailsPageState();
}

class _FriendDetailsPageState extends State<FriendDetailsPage> {
  FriendsListItemResult _friendsListItemResult;
  
  @override
  Widget build(BuildContext context) {
    _friendsListItemResult = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              ChatIcon.gengduo,
              size: 25,
            ),
            onPressed: () {},
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            FriendHeadInfo(
              nickname: _friendsListItemResult?.user_nickname ?? '',
              username: _friendsListItemResult?.user_username ?? '',
              remarks: _friendsListItemResult?.friends_remark ?? '',
              avatar: _friendsListItemResult?.user_avatar ?? '',
              option: false,
            ),
            MenuListMessage(
                messages: ['设置备注和标签', '朋友权限'], onTap: onMenuMessage),
            SizedBox(height: 15),
            MenuListMessage(messages: ['朋友圈', '更多消息'], onTap: onMenuMessage),
            SizedBox(height: 15),
            MenuListCustom(
              child: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(ChatIcon.xiaoxi, size: 28),
                    SizedBox(width: 5),
                    Text('发消息'),
                  ],
                ),
              ],
              onTap: onMenuCustom,
            ),
          ],
        ),
      ),
    );
  }

  void onMenuMessage(String message) {
    BasisTool.showToast(message: "你点击了: $message");
  }
  void onMenuCustom(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/chat-message-details', arguments: M.MessageFriendsResult.fromJson({
        'user': {
          'id': _friendsListItemResult.friendId,
          'nickname': _friendsListItemResult.user_nickname,
          'username': _friendsListItemResult.user_username,
          'avatar': _friendsListItemResult.user_avatar,
          'signature': _friendsListItemResult.user_signature,
          'remark': _friendsListItemResult.friends_remark,
          'status': _friendsListItemResult.friends_status,
        }
      }));
    }
  }
}
