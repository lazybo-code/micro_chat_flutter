import 'package:flutter/material.dart';
import 'package:micro_chat/components/chat_message_item_view.dart';
import 'package:micro_chat/provider/message_provider.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/types/message_friends_result.dart' as M;
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await Provider.of<MessageProvider>(context, listen: false).loadMessageFriends();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: _chatItems(),
    );
  }

  List<Widget> _chatItems() {
    List<M.MessageFriendsResult> messageFriendsResult = Provider.of<MessageProvider>(context).messageFriendsResult;
    if (messageFriendsResult.length > 0) {
      messageFriendsResult.sort((a,b) => DateTime.parse(a.createTime).millisecondsSinceEpoch < DateTime.parse(b.createTime).millisecondsSinceEpoch ? 1 : -1);
      return messageFriendsResult.map((e) {
        return ChatListItemView(
          image: e.user?.avatar ?? '',
          title: e.user?.remark ?? e.user?.nickname ?? '',
          desc: getDesc(e),
          time: BasisTool.getDate(e.createTime),
          onTap: () => Navigator.pushNamed(context, '/chat-message-details', arguments: e),
        );
      }).toList();
    }
    return [];
  }

  String getDesc(M.MessageFriendsResult temp) {
    switch(temp.type) {
      case 'text':
        return temp.text.text;
        break;
      case 'image':
        return '[图片]';
        break;
      case 'voice':
        return '[语音]';
        break;
    }
    return '';
  }

}
