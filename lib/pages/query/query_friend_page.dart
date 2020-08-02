import 'package:flutter/material.dart';
import 'package:micro_chat/components/chat_message_item_view.dart';
import 'package:micro_chat/components/toast.dart';
import 'package:micro_chat/icon/chat_icon.dart';
import 'package:micro_chat/provider/friends_provider.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/types/query_friends_result.dart';
import 'package:provider/provider.dart';

class QueryFriendPage extends StatefulWidget {
  @override
  _QueryFriendPageState createState() => _QueryFriendPageState();
}

class _QueryFriendPageState extends State<QueryFriendPage> {
  ThemeData _theme;
  FriendsProvider _friendsProvider;
  String _value = "";

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _friendsProvider = Provider.of<FriendsProvider>(context);
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: _theme.backgroundColor,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: getList(),
      ),
    );
  }

  List<Widget> getList() {
    return _friendsProvider.queryFriends.map((e) {
      return ChatListItemView(
        title: e.friend_remark ?? e.user_username ?? '',
        image: e.user_avatar ?? '',
        border: true,
        style: ChatListStyle.custom,
        onTap: () {},
        custom: Container(
          child: _listItemStatus(e),
        ),
      );
    }).toList();
  }

  Widget _listItemStatus(QueryFriendsResult e) {
    if (e.friend_status != null && (e.friend_status == 'agree' || e.friend_status == 'apply')) {
      return Text(
        e.friend_status == 'agree' ? '已添加' : '申请中',
        style: _theme.textTheme.subtitle2,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return RaisedButton(
        color: _theme.primaryColor,
        onPressed: () async {
          Toast.showLoading(
            context,
            msg: Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Text('申请..', style: TextStyle(color: _theme.primaryColorDark),),
            ),
            ballColor: _theme.primaryColorDark,
          );
          await _friendsProvider.addFriend(_value, e.user_id, '请求添加好友');
          Future.delayed(Duration(seconds: 1), () {
            Toast.close(context);
          });
        },
        child: Text(
          '添加',
          style: TextStyle(color: _theme.primaryColorDark),
        ),
      );
    }
  }

  Widget _appBar() {
    return AppBar(
      elevation: .5,
      titleSpacing: 0,
      title: Container(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 3.0,
              horizontal: 5.0,
            ),
            hintText: '搜索好友',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
              gapPadding: 0,
            ),
            filled: true,
            fillColor: _theme.primaryColorDark.withOpacity(.04),
          ),
          textInputAction: TextInputAction.done,
          autofocus: true,
          onChanged: (value) => setState(() => _value = value),
          onSubmitted: (String value) async {
            if (value.trim().length == 0) {
              BasisTool.showToast(message: "请输入微聊号或者账号");
              return;
            }
            Toast.showLoading(
              context,
              msg: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('搜索中'),
              ),
            );
            await _friendsProvider.getQueryFriends(value);
            Toast.close(context);
          },
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(ChatIcon.sousuo),
          onPressed: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }
}
