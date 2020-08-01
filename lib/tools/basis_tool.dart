import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

class BasisTool {
  static String BASE_URL = 'http://192.168.0.103:3000';

  /// 在main runApp后面执行, 安卓沉浸
  static setImmerse() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Color(0x00000000));
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red,
        g = color.green,
        b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  static void showToast({
    String message = "",
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 1,
    Color backgroundColor = const Color(0xff333333),
    Color textColor = const Color(0xffffffff),
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  //初始化通信管道-设置退出到手机桌面
  static const String CHANNEL = "android/back/desktop";

  //设置回退到手机桌面
  static Future<bool> backDeskTop() async {
    final platform = MethodChannel(CHANNEL);
    //通知安卓返回,到手机桌面
    try {
      final bool out = await platform.invokeMethod('backDesktop');
      if (out) debugPrint('返回到桌面');
    } on PlatformException catch (e) {
      debugPrint("通信失败(设置回退到安卓手机桌面:设置失败)");
      print(e.toString());
    }
    return Future.value(false);
  }

  //根据给定的日期得到format后的日期
  static String getDate(String dateOriginal) {
    //现在的日期
    var today = DateTime.now();
    //今天的23:59:59
    var standardDate = DateTime(today.year, today.month, today.day, 23, 59, 59);
    //传入的日期与今天的23:59:59秒进行比较
    Duration diff = standardDate.difference(DateTime.parse(dateOriginal));
    if (diff < Duration(days: 1)) {
      return dateOriginal.substring(11, 16);
    } else if (diff >= Duration(days: 1) && diff < Duration(days: 2)) {
      return "昨天 " + dateOriginal.substring(11, 16);
    } else {
      return dateOriginal.substring(0, 16);
    }
  }

  static permissionMicrophoneApply() {
    Future<PermissionStatus> status = Permission.microphone.request();
    status.then((stat) {
      if (stat != PermissionStatus.granted) {
        showToast(message: "需要权限, 否则功能无法正常使用。");
      }
    });
  }

  static Future<bool> permissionCameraApply() async {
    Future<PermissionStatus> status = Permission.camera.request();
    return await status.then((stat) {
      if (stat != PermissionStatus.granted) {
        showToast(message: "需要权限, 否则功能无法正常使用。");
      }
      return !(stat != PermissionStatus.granted);
    });
  }

  static Future<String> tempFile({String suffix}) async {
    suffix ??= 'tmp';

    if (!suffix.startsWith('.')) {
      suffix = '.$suffix';
    }
    var uuid = Uuid();
    var tmpDir = await getTemporaryDirectory();
    var path = '${join(tmpDir.path, uuid.v4())}$suffix';
    var parent = dirname(path);
    Directory(parent).createSync(recursive: true);

    return path;
  }
}
