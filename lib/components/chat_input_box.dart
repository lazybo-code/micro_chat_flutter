import 'package:flutter/material.dart';
import 'package:micro_chat/icon/chat_icon.dart';

import 'animation_on_color.dart';

class ChatInputBox extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final double height;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final String hintText;
  final String voiceHintText;
  final VoidCallback onVoice;
  final VoidCallback onExpression;
  final VoidCallback onAdd;
  final bool voice;

  final GestureTapCallback onVoiceTap;
  final GestureTapDownCallback onVoiceTapDown;
  final GestureTapUpCallback onVoiceTapUp;
  final GestureTapCancelCallback onVoiceTapCancel;

  const ChatInputBox({
    Key key,
    this.focusNode,
    this.controller,
    this.height = 60,
    this.onChanged,
    this.onSubmitted,
    this.hintText = '发送消息',
    this.voiceHintText = '按住说话',
    this.onVoice,
    this.onExpression,
    this.onAdd,
    this.voice = true,
    this.onVoiceTap,
    this.onVoiceTapDown,
    this.onVoiceTapUp,
    this.onVoiceTapCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Color _color = _theme.primaryColorDark.withOpacity(.04);

    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 8),
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        border: Border(
          top: BorderSide(
            color: _theme.dividerColor.withOpacity(.05),
          ),
        ),
      ),
      height: height,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: <Widget>[
            voice == false
                ? _iconBtn(ChatIcon.voice, onPressed: onVoice)
                : _iconBtn(ChatIcon.keyboard, onPressed: onVoice),
            Flexible(
              child: Container(
                child: _voice(_color),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: voice == true ? _color : null,
                ),
              ),
            ),
            _iconBtn(ChatIcon.xiaolian, onPressed: onExpression),
            _iconBtn(ChatIcon.address, onPressed: onAdd),
          ],
        ),
      ),
    );
  }

  Widget _voice(Color color) {
    if (voice == false) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
            gapPadding: 0,
          ),
          filled: true,
          fillColor: color,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        textInputAction: TextInputAction.send,
      );
    }
    return AnimationOnColor(
      child: Center(
        child: Text(
          voiceHintText,
          style: TextStyle(fontSize: 15),
        ),
      ),
      onTap: onVoiceTap,
      onTapUp: onVoiceTapUp,
      onTapDown: onVoiceTapDown,
      onTapCancel: onVoiceTapCancel,
    );
  }

  Widget _iconBtn(IconData icon, {VoidCallback onPressed}) {
    return IconButton(
      padding: EdgeInsets.only(bottom: 3),
      icon: Icon(icon, size: 30),
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
