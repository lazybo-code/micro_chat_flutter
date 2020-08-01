import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'loading/loading_widget.dart';

class Toast {
  static showLoading(
    BuildContext context, {
    @required Widget msg,
    double radius = 18,
    double minLineWidth: 2.4,
    double maxLineWidth: 4.8,
    double minLineHeight: 4.8,
    double maxLineHeight: 9.6,
    double minBallAlpha: 77,
    double maxBallAlpha: 255,
    Color ballColor: Colors.red,
    Duration duration: const Duration(milliseconds: 500),
  }) {
    return showDialog(
      context: context,
      builder: (context) => LoadingToast(
        msg,
        radius: radius,
        minLineWidth: minLineWidth,
        maxLineWidth: maxLineWidth,
        minLineHeight: minLineHeight,
        maxLineHeight: maxLineHeight,
        minBallAlpha: minBallAlpha,
        maxBallAlpha: maxBallAlpha,
        ballColor: ballColor,
        duration: duration,
      ),
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class LoadingToast extends Dialog {
  final Widget msg;
  final double radius;
  final double minLineWidth;
  final double maxLineWidth;
  final double minLineHeight;
  final double maxLineHeight;
  final double minBallAlpha;
  final double maxBallAlpha;
  final Color ballColor;
  final Duration duration;

  LoadingToast(
    this.msg, {
    this.radius = 18,
    this.minLineWidth: 2.4,
    this.maxLineWidth: 4.8,
    this.minLineHeight: 4.8,
    this.maxLineHeight: 9.6,
    this.minBallAlpha: 77,
    this.maxBallAlpha: 255,
    this.ballColor: Colors.red,
    this.duration: const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: Container(
              decoration: ShapeDecoration(
                color: _theme.backgroundColor,
                shadows: [
                  BoxShadow(
                    color: _theme.primaryColorDark.withOpacity(.14),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LineSpinFadeLoaderIndicator(
                    radius: radius,
                    minBallAlpha: minBallAlpha,
                    maxBallAlpha: maxBallAlpha,
                    maxLineHeight: maxLineHeight,
                    maxLineWidth: maxLineWidth,
                    minLineHeight: minLineHeight,
                    minLineWidth: minLineWidth,
                    ballColor: ballColor,
                    duration: duration,
                  ),
                  msg,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<T> showDialog<T>(
    {@required BuildContext context,
    @required WidgetBuilder builder,
    bool useRootNavigator = true,
    RouteSettings routeSettings,
    Duration transitionDuration = const Duration(milliseconds: 250)}) {
  assert(builder != null);
  assert(useRootNavigator != null);
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: transitionDuration,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return WillPopScope(
          child: builder(context), onWillPop: () async => false);
    },
    transitionBuilder: _buildCupertinoDialogTransitions,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
  );
}

final Animatable<double> _dialogScaleTween = Tween<double>(begin: 1.3, end: 1.0)
    .chain(CurveTween(curve: Curves.linearToEaseOut));

Widget _buildCupertinoDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  final CurvedAnimation fadeAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  if (animation.status == AnimationStatus.reverse) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }
  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      child: child,
      scale: animation.drive(_dialogScaleTween),
    ),
  );
}
