import 'package:flutter/material.dart';

import 'cache_net_image.dart';
import 'f_l_bubble.dart';

class ChatMessageNews extends StatelessWidget {
  final bool right;
  final String avatar;
  final String avatarRight;
  final String message;
  final double maxWidth;
  final Size avatarSize;

  const ChatMessageNews({
    Key key,
    this.right = false,
    this.avatar,
    this.avatarRight,
    this.message,
    this.maxWidth,
    this.avatarSize = const Size(45, 45),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Alignment _alignment =
        right == false ? Alignment.centerLeft : Alignment.centerRight;
    FLBubbleFrom _flBubbleFrom =
        right == false ? FLBubbleFrom.left : FLBubbleFrom.right;
    Color _backgroundColor = right == false
        ? _theme.backgroundColor
        : _theme.accentIconTheme.color.withOpacity(.40);

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _avatar(show: right == false, image: avatar),
          Expanded(
            child: Container(
              alignment: _alignment,
              child: FLBubble(
                from: _flBubbleFrom,
                backgroundColor: _backgroundColor,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        maxWidth ?? MediaQuery.of(context).size.width - 120,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 15),
                    softWrap: true,
                  ),
                ),
              ),
            ),
          ),
          _avatar(show: right == true, image: avatarRight),
        ],
      ),
    );
  }

  Widget _avatar({bool show = false, String image}) {
    if (show == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CacheNetImage(
          image: image ?? '',
          width: avatarSize.width,
          height: avatarSize.height,
        ),
      );
    }
    return SizedBox();
  }
}
