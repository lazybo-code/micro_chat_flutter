import 'package:flutter/material.dart';
import 'package:micro_chat/components/chat_message_item_view.dart';
import 'package:micro_chat/components/toast.dart';
import 'package:micro_chat/icon/chat_icon.dart';
import 'package:micro_chat/provider/friends_provider.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/types/friends_list_result.dart';
import 'package:provider/provider.dart';

class FriendNewsDetailsPage extends StatefulWidget {
  FriendNewsDetailsPage({Key key}) : super(key: key);

  @override
  _FriendNewsDetailsPageState createState() => _FriendNewsDetailsPageState();
}

class _FriendNewsDetailsPageState extends State<FriendNewsDetailsPage> {
  ThemeData _theme;
  List<FriendsListItemResult> _friendsApply;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await Provider.of<FriendsProvider>(context, listen: false)
        .getFriendsApply();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _friendsApply = Provider.of<FriendsProvider>(context).friendsApply;
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: _theme.backgroundColor,
      body: ListView(
        children: _friendsApply.map((e) {
          return ChatListItemView(
            title: e.friends_remark ?? e.user_nickname,
            image: e.user_avatar ?? '',
            desc: e.friends_description ?? '',
            status: e.friends_status,
            border: true,
            style: ChatListStyle.apply,
            onApply: (String status) async {
              Toast.showLoading(
                context,
                msg: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text('加载中...', style: TextStyle(color: _theme.primaryColorDark),),
                ),
                ballColor: _theme.primaryColorDark,
              );
              await Provider.of<FriendsProvider>(context, listen: false).putApplyStatus(e.userId.toString(), status);
              Future.delayed(Duration(seconds: 1), () {
                Toast.close(context);
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: .5,
      titleSpacing: 0,
      title: Text('新的朋友'),
      actions: <Widget>[
        GestureDetector(
          child: Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: Text(
              '新的朋友',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _theme.primaryColorDark.withOpacity(.04),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                ChatIcon.sousuo,
                color: _theme.dividerColor.withOpacity(.4),
                size: 20,
              ),
              SizedBox(width: 2),
              Text(
                '微聊号/昵称',
                style: TextStyle(
                  color: _theme.dividerColor.withOpacity(.4),
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(35),
      ),
    );
  }
}
