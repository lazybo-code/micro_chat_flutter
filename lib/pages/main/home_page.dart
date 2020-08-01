import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micro_chat/event/result_error_event.dart';
import 'package:micro_chat/event/router_event.dart';
import 'package:micro_chat/event/socket_event.dart';
import 'package:micro_chat/icon/chat_icon.dart';
import 'package:micro_chat/pages/main/findings_page.dart';
import 'package:micro_chat/pages/main/friends_page.dart';
import 'package:micro_chat/pages/main/message_page.dart';
import 'package:micro_chat/pages/main/personal_page.dart';
import 'package:micro_chat/provider/message_provider.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/types/main_type.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<HomeNavigation> _navigation = [
    HomeNavigation(icon: ChatIcon.xiaoxi, title: '微聊'),
    HomeNavigation(icon: ChatIcon.tongxunlu, title: '通讯录'),
    HomeNavigation(icon: ChatIcon.faxian, title: '发现'),
    HomeNavigation(icon: ChatIcon.lingdaopishi, title: '我', appBar: false),
  ];
  PageController _pageController;
  StreamSubscription _socketConnectEvent;
  ThemeData _theme;
  int _currentIndex = 0;
  IO.Socket socket;
  MessageProvider _messageProvider;
  StreamSubscription _authErrorEvent;
  StreamSubscription _routerSwitchEvent;
  String route = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _socketConnectEvent = socketEventBus.on<SocketConnectEvent>().listen((SocketConnectEvent event) {
      if (socket != null) socket.destroy();
      socket = IO.io('${BasisTool.BASE_URL}?authorization=Bearer ${event.token}', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });
      socket.on('connect', (_) {
        print('socket: connect success');
      });
      socket.on('disconnect', (_) => BasisTool.showToast(message: "socket: disconnect"));
      socket.on('message', (data) {
        if (data['message'] == 'text') {
          data['text']['user'] = data['user'];
          _messageProvider.setMessageFriend(data['text']['userId'], data['text']['friendId'], data['text']);
          _messageProvider.setTextMessage(data['text']);
        }
      });
      socket.on('friend', (data) => print("friend: ${data.toString()}"));
    });
    _authErrorEvent = resultErrorEventBus.on<AuthErrorEvent>().listen((AuthErrorEvent event) {
      print('err: ${route}');
      if (route != '/login' && route.trim().length > 0) {
        Navigator.of(context).pushNamed('/login');
      }
    });
    _routerSwitchEvent = routerEventBus.on<RouterSwitchEvent>().listen((RouterSwitchEvent event) {
      print("router: ${event.router}");
      route = event.router;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _socketConnectEvent.cancel();
    _authErrorEvent.cancel();
    _routerSwitchEvent.cancel();
    socket.destroy();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _messageProvider = Provider.of<MessageProvider>(context, listen: true);

    return Scaffold(
      appBar: _appBar(),
      backgroundColor: _theme.backgroundColor,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          MessagePage(),
          FriendsPage(),
          FindingsPage(),
          PersonalPage()
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _appBar() {
    HomeNavigation item = _navigation[_currentIndex];
    if (item.appBar == false) return null;
    return AppBar(
      elevation: .5,
      title: Text(item.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(ChatIcon.sousuo),
          onPressed: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          icon: Icon(
            ChatIcon.add,
            size: 20,
          ),
          onPressed: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return CupertinoTabBar(
      currentIndex: _currentIndex,
      backgroundColor: _theme.backgroundColor,
      activeColor: _theme.accentIconTheme.color,
      items: _navigation.map((e) {
        return BottomNavigationBarItem(
          icon: Icon(e.icon),
          title: Text(e.title),
        );
      }).toList(),
      onTap: (int index) => setState(() {
        _currentIndex = index;
        _pageController.jumpToPage(index);
      }),
    );
  }
}
