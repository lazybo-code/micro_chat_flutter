import 'package:flutter/material.dart';

class AnimationOnColor extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final GestureTapDownCallback onTapDown;
  final GestureTapUpCallback onTapUp;
  final GestureTapCancelCallback onTapCancel;
  final double borderRadius;
  final double height;
  final EdgeInsetsGeometry padding;

  const AnimationOnColor({
    Key key,
    this.child,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.height,
    this.borderRadius = 5,
    this.padding,
  }) : super(key: key);

  @override
  _AnimationOnColorState createState() => _AnimationOnColorState();
}

class _AnimationOnColorState extends State<AnimationOnColor>
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
    return GestureDetector(
      child: Container(
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _theme.primaryColorDark.withOpacity(_controller.value),
          borderRadius: BorderRadius.circular(widget.borderRadius)
        ),
        child: widget.child,
      ),
      onTap: widget.onTap,
      onTapDown: (_) {
        _controller.forward();
        if (widget.onTapDown != null) {
          widget.onTapDown(_);
        }
      },
      onTapUp: (_) {
        _controller.reverse();
        if (widget.onTapUp != null) {
          widget.onTapUp(_);
        }
      },
      onTapCancel: () {
        _controller.reverse();
        if (widget.onTapCancel != null) {
          widget.onTapCancel();
        }
      },
    );
  }
}
