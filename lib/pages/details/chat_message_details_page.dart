import 'package:flutter/material.dart';
import 'package:micro_chat/components/chat_input_box.dart';
import 'package:micro_chat/components/chat_message_news.dart';
import 'package:micro_chat/icon/chat_icon.dart';
import 'package:micro_chat/provider/message_provider.dart';
import 'package:micro_chat/provider/user_provider.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/tools/dio/result_data.dart';
import 'package:micro_chat/types/message_friends_result.dart' as M;
import 'package:micro_chat/types/message_news_result.dart' as Mn;
import 'package:provider/provider.dart';

class ChatMessageDetailsPage extends StatefulWidget {
  @override
  _ChatMessageDetailsPageState createState() => _ChatMessageDetailsPageState();
}

class _ChatMessageDetailsPageState extends State<ChatMessageDetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  M.MessageFriendsResult _messageFriendsResult;
  ThemeData _theme;
  String message = '';
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  ScrollController _singController = ScrollController();
  UserProvider _userProvider;
  bool voice = false;
  MessageProvider _messageProvider;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _messageProvider.loadMessage(
        _messageFriendsResult.user.id.toString(),
        load: true,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).viewInsets.bottom == 0) {
        _singController.jumpTo(_singController.position.maxScrollExtent);
      } else {
        _singController.jumpTo(_singController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    focusNode?.dispose();
    textEditingController?.dispose();
    _singController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _messageProvider = Provider.of<MessageProvider>(context, listen: true);
    _theme = Theme.of(context);
    _messageFriendsResult = ModalRoute.of(context).settings.arguments;
    List<Mn.MessageNewsResult> _messageNewResult = _messageProvider.messageNewResult;
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        titleSpacing: 0,
        title: Text(
          _messageFriendsResult.user.remark ??
              _messageFriendsResult.user.nickname,
        ),
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
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                child: GestureDetector(
                  child: SingleChildScrollView(
                    controller: _singController,
                    physics: BouncingScrollPhysics(),
                    child: ListBody(
                      reverse: true,
                      children: [
                        SizedBox(height: 10),
                        ..._messageNewResult.map((e) {
                          return ChatMessageNews(
                            message: e.type == 'text' ? e.text.text : e.type,
                            right: e.userId != _messageFriendsResult.user.id,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  onTap: () {
                    focusNode.unfocus();
                  },
                ),
              ),
            ),
            ChatInputBox(
              focusNode: focusNode,
              controller: textEditingController,
              onVoice: () {
                focusNode.unfocus();
                setState(() => voice = !voice);
              },
              voice: voice,
              onChanged: (value) => setState(() => message = value),
              onSubmitted: _sendMessage,
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: true,
    );
  }

  void _sendMessage(String value) async {
    FocusScope.of(context).requestFocus(focusNode);
    ResultData resultData = await _messageProvider.sendTextMessage(
      _messageFriendsResult.user.id.toString(),
      message,
    );
    if (resultData.isSuccess == false) {
      BasisTool.showToast(message: "消息发送失败");
    }
    message = textEditingController.text = '';
  }

  get leftImageURL {
    return _messageFriendsResult.user.avatar ?? '';
  }

  get rightImageURL {
    return _userProvider.userProfileResult.avatar ?? '';
  }
}
