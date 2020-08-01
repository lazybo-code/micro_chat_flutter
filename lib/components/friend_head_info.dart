import 'package:flutter/material.dart';
import 'package:micro_chat/components/cache_net_image.dart';
import 'package:micro_chat/icon/chat_icon.dart';

class FriendHeadInfo extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final String avatar;
  final double height;
  final Size avatarSize;
  final Color avatarBackgroundColor;
  final String nickname;
  final String remarks;
  final String username;
  final bool option;
  final IconData icon;
  final IconData iconR;
  final Function onIcon;
  final Function onIconR;
  final Function onUsername;

  const FriendHeadInfo({
    Key key,
    this.padding =
        const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 35),
    this.borderRadius = 5.0,
    this.avatar = '',
    this.avatarSize = const Size(82, 82),
    this.avatarBackgroundColor = const Color(0xffffffff),
    this.nickname,
    this.remarks,
    this.username,
    this.option = true,
    this.height = 140,
    this.icon = ChatIcon.qrCode,
    this.iconR = Icons.keyboard_arrow_right,
    this.onIcon,
    this.onIconR,
    this.onUsername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return _headBox(
      _theme,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CacheNetImage(
              image: avatar,
              width: avatarSize.width,
              height: avatarSize.height,
              loadingBackgroundColor: avatarBackgroundColor,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: _textOption(),
          ),
        ],
      ),
    );
  }

  Widget _textOption() {
    if (option == true) {
      return Container(
        padding: EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                nickname ?? '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        username != null ? '微聊号: $username' : '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    _iconButton(icon, size: 22, onTap: onIcon),
                    _iconButton(iconR, size: 25, onTap: onIconR),
                  ],
                ),
              ),
              onTap: onUsername,
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          remarks != null && remarks.trim().length > 0 ? remarks : nickname ?? '',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2),
        remarks != null && remarks.trim().length > 0
            ? Text('昵称: $nickname', overflow: TextOverflow.ellipsis)
            : SizedBox(),
        Text(
          username != null ? '微聊号: $username' : '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon, {double size, Function onTap}) {
    return IconButton(
      padding: EdgeInsets.all(0),
      constraints: BoxConstraints(maxHeight: 30),
      icon: Icon(icon, size: size),
      onPressed: onTap,
    );
  }

  Widget _headBox(ThemeData _theme, {Widget child}) {
    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        border: Border(
          bottom: BorderSide(color: _theme.dividerColor.withOpacity(.05)),
        ),
      ),
      child: child,
    );
  }
}
