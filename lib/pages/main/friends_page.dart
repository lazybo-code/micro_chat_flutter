import 'package:flutter/material.dart';
import 'package:micro_chat/components/chat_message_item_view.dart';
import 'package:micro_chat/provider/friends_provider.dart';
import 'package:micro_chat/types/friends_list_result.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({Key key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  ThemeData _theme;

  @override
  void initState() {
    super.initState();
    loadFriends();
  }

  void loadFriends() async {
    await Provider.of<FriendsProvider>(context, listen: false).getFriends();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        ChatListItemView(
          title: '新的朋友',
          image: 'images/add_friend.png',
          imageAccess: true,
          border: false,
          loadingBackgroundColor: Color(0xffFB9F3C),
          style: ChatListStyle.friend,
          onTap: () => Navigator.pushNamed(context, '/friend-news-details'),
        ),
        ..._itemResult(),
      ],
    );
  }

  List<Widget> _itemResult() {
    List<Widget> item = [];
    FriendsProvider _friendsProvider = Provider.of<FriendsProvider>(context);
    _friendsProvider.friends.keys.forEach((key) {
      if (_friendsProvider.friends[key].length == 0) return;
      item.add(
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          color: _theme.primaryColorDark.withOpacity(.04),
          child: Text(
            key,
            style: TextStyle(
              color: _theme.textTheme.subtitle2.color,
            ),
          ),
        ),
      );
      _friendsProvider.friends[key].forEach((friend) {
        FriendsListItemResult temp = FriendsListItemResult.fromJson(friend);
        item.add(
          ChatListItemView(
            title: temp.friends_remark ?? temp.user_nickname,
            image: temp.user_avatar ?? '',
            border: true,
            style: ChatListStyle.friend,
            onTap: () => Navigator.pushNamed(context, '/friend-details', arguments: temp),
          ),
        );
      });
    });
    return item;
  }
}
