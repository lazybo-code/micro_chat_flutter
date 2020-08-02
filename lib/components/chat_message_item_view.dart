import 'package:flutter/material.dart';
import 'package:micro_chat/components/cache_net_image.dart';

enum ChatListStyle { message, friend, apply, custom }

class ChatListItemView extends StatefulWidget {
  final String image;
  final String title;
  final String desc;
  final String time;
  final bool notice;
  final Function onTap;
  final ChatListStyle style;
  final bool border;
  final bool imageAccess;
  final Color loadingBackgroundColor;
  final String status;
  final ValueChanged<String> onApply;
  final Widget custom;

  const ChatListItemView({
    Key key,
    this.image,
    this.title,
    this.desc,
    this.time,
    this.notice = true,
    this.border = true,
    this.style = ChatListStyle.message,
    this.onTap,
    this.imageAccess = false,
    this.loadingBackgroundColor = Colors.white,
    this.status,
    this.onApply,
    this.custom,
  }) : super(key: key);

  @override
  _ChatListItemViewState createState() => _ChatListItemViewState();
}

class _ChatListItemViewState extends State<ChatListItemView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.1,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return _animation(
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CacheNetImage(
              access: widget.imageAccess,
              image: widget.image,
              width: 45,
              height: 45,
              loadingBackgroundColor: widget.loadingBackgroundColor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: _border(),
              ),
              padding: EdgeInsets.only(right: 15, bottom: 10),
              margin: EdgeInsets.only(top: 10),
              child: _children(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _children() {
    if (widget.style == ChatListStyle.message) {
      return _messageTextItem();
    }
    if (widget.style == ChatListStyle.apply) {
      return _applyTextItem();
    }
    if (widget.style == ChatListStyle.custom) {
      return _customTextItem();
    }
    return Text(
      widget.title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }

  Border _border() {
    if (widget.border == false) return null;
    return Border(
      bottom: BorderSide(
        color: _theme.dividerColor.withOpacity(.04),
        width: .6,
      ),
    );
  }

  Widget _animation({@required Widget child}) {
    return GestureDetector(
      child: Container(
        height: 70,
        padding: EdgeInsets.only(left: 15),
        color: _theme.primaryColorDark.withOpacity(_controller.value),
        child: child,
      ),
      onTap: () => widget.onTap != null ? widget.onTap() : {},
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
    );
  }

  Widget _customTextItem() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        widget.custom,
      ],
    );
  }

  Widget _applyTextItem() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                widget.desc,
                style: _theme.textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        widget.status == 'agree' || widget.status == 'refusal'
            ? Container(
                alignment: Alignment.center,
                child: Text(
                  widget.status == 'agree' ? '已添加' : '已拒绝',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: _theme.dividerColor.withOpacity(.4),
                  ),
                ),
              )
            : Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 65,
                      child: RaisedButton(
                        color: _theme.primaryColor,
                        onPressed: () {
                          if (widget.onApply != null) widget.onApply('agree');
                        },
                        child: Text(
                          '同意',
                          style: TextStyle(color: _theme.primaryColorDark),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 65,
                      child: RaisedButton(
                        color: Colors.redAccent.withOpacity(.8),
                        textColor: Colors.white,
                        splashColor: Colors.red,
                        onPressed: () {
                          if (widget.onApply != null)
                            widget.onApply('refusal');
                        },
                        child: Text('拒绝'),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _messageTextItem() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                widget.desc,
                style: _theme.textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Text(
                widget.time,
                style: TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            widget.notice == false
                ? Icon(
                    Icons.notifications_off,
                    size: 15,
                    color: _theme.dividerColor,
                  )
                : SizedBox()
          ],
        ),
      ],
    );
  }
}
