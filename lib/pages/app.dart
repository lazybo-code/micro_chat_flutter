import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:micro_chat/event/router_event.dart';
import 'package:micro_chat/pages/auth/login_page.dart';
import 'package:micro_chat/pages/details/chat_message_details_page.dart';
import 'package:micro_chat/pages/details/friend_details_page.dart';
import 'package:micro_chat/pages/main/home_page.dart';
import 'package:micro_chat/tools/basis_tool.dart';

import 'details/friend_news_details_page.dart';
import 'details/qr_code_details_page.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '微聊',
      theme: ThemeData(
        primarySwatch: BasisTool.createMaterialColor(Color(0xffffffff)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Color(0xffffffff),
        accentIconTheme: IconThemeData(color: Color(0xff07C261)),
        cardColor: Color(0x88ffffff),
        primaryColorDark: Color(0xff1B1B1B),
        textTheme: TextTheme().copyWith(
          bodyText2: TextStyle(color: Color(0xff1B1B1B)),
          bodyText1: TextStyle(color: Color(0xff1B1B1B)),
          subtitle1: TextStyle(color: Color(0xff1B1B1B)),
          subtitle2: TextStyle(color: Color(0x861b1b1b)),
        ),
        cursorColor: Color(0xff07C261),
        splashColor: Color(0xff07C261),
        textSelectionColor: Color(0xff07C261),
        textSelectionHandleColor: Color(0xff07C261),
      ),
      darkTheme: ThemeData(
        primarySwatch: BasisTool.createMaterialColor(Color(0xff1B1B1B)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Color(0xff1B1B1B),
        accentIconTheme: IconThemeData(color: Color(0x88ffffff)),
        cardColor: Color(0x88ffffff),
        primaryColorDark: Color(0x88ffffff),
        textTheme: TextTheme().copyWith(
          bodyText1: TextStyle(color: Color(0x88ffffff)),
          bodyText2: TextStyle(color: Color(0x88ffffff)),
          subtitle1: TextStyle(color: Color(0x88ffffff)),
          subtitle2: TextStyle(color: Color(0x88ffffff)),
        ),
        dividerColor: Color(0x88ffffff),
        cursorColor: Color(0x88ffffff),
        splashColor: Color(0x88ffffff),
        textSelectionColor: Color(0x88ffffff),
        textSelectionHandleColor: Color(0x88ffffff),
      ),
      home: HomePage(),
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/chat-message-details': (BuildContext context) => ChatMessageDetailsPage(),
        '/friend-details': (BuildContext context) => FriendDetailsPage(),
        '/friend-news-details': (BuildContext context) => FriendNewsDetailsPage(),
        '/qr-code-details': (BuildContext context) => QrCodeDetailsPage(),
      },
      initialRoute: '/login',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CN'),
        const Locale('en', 'US'),
      ],
      navigatorObservers: [
        MyObserver(),
      ],
    );
  }

}

class MyObserver extends NavigatorObserver{
  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    routerEventBus.fire(RouterSwitchEvent(route.settings.name));
  }
}