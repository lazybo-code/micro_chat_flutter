import 'package:flutter/material.dart';
import 'package:micro_chat/components/friend_head_info.dart';
import 'package:micro_chat/components/menu_list.dart';
import 'package:micro_chat/icon/chat_icon.dart';
import 'package:micro_chat/provider/user_provider.dart';
import 'package:provider/provider.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key key}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            FriendHeadInfo(
              nickname: _userProvider.userProfileResult.nickname ?? '',
              username: _userProvider.userProfileResult.username ?? '',
              avatar: _userProvider.userProfileResult.avatar ?? '',
              option: true,
            ),
            SizedBox(height: 15),
            MenuListIcon(child: [
              MenuListIconItem(ChatIcon.souChan, '收藏'),
              MenuListIconItem(ChatIcon.tuPian, '相册'),
            ]),
            SizedBox(height: 15),
            MenuListIcon(child: [
              MenuListIconItem(ChatIcon.setting, '设置'),
            ]),
          ],
        ),
      ),
    );
  }
}
