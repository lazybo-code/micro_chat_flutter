import 'package:flutter/material.dart';
import 'package:micro_chat/components/rounded_button.dart';
import 'package:micro_chat/components/rounded_input_field.dart';
import 'package:micro_chat/components/rounded_password_field.dart';
import 'package:micro_chat/event/socket_event.dart';
import 'package:micro_chat/icon/chat_icon.dart';
import 'package:micro_chat/provider/user_provider.dart';
import 'package:micro_chat/tools/basis_tool.dart';
import 'package:micro_chat/tools/preference_tool.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ThemeData _theme;
  bool obscureText = true;
  bool obscureText1 = true;
  bool obscureText2 = true;
  Map<String, String> _dataLogin = {
    'username': "",
    'password': "",
  };
  Map<String, String> _dataRegister = {
    'nickname': "",
    'username': "",
    'password': "",
    'passwordNew': "",
  };

  FocusNode username = new FocusNode(debugLabel: 'username');
  FocusNode password = new FocusNode(debugLabel: 'password');
  FocusNode nickname = new FocusNode(debugLabel: 'nickname');
  FocusNode regUsername = new FocusNode(debugLabel: 'regUsername');
  FocusNode regPassword = new FocusNode(debugLabel: 'regPassword');
  FocusNode regPasswordNew = new FocusNode(debugLabel: 'regPasswordNew');

  bool loading = false;
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;
  BorderRadius _borderRadius = BorderRadius.only(
    topLeft: Radius.circular(5),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  final TextStyle _headText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 30,
  );
  final TextStyle _descText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
    isLogin();
  }

  void isLogin() async {
    bool status =
        await Provider.of<UserProvider>(context, listen: false).userProfile();
    if (status == true) {
      String token = await PreferenceTool.loadData('Authorization');
      socketEventBus.fire(SocketConnectEvent(token));
      Navigator.pop(context);
      return;
    }
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return WillPopScope(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(),
          ),
          preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top),
        ),
        backgroundColor: _theme.backgroundColor,
        body: Scrollbar(
          child: SingleChildScrollView(
            child: FadeTransition(
              opacity: _controller,
              child: AnimatedCrossFade(
                firstChild: _login(),
                duration: Duration(milliseconds: 300),
                crossFadeState: _crossFadeState,
                secondChild: _register(),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () {
        if (_crossFadeState != CrossFadeState.showFirst) {
          setState(() => _crossFadeState = CrossFadeState.showFirst);
        } else {
          BasisTool.backDeskTop();
        }
        return;
      },
    );
  }

  Widget _register() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('欢迎注册 微聊', style: _headText),
          Text('超级坑', style: _descText),
          SizedBox(height: 60),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: _theme.primaryColorDark.withOpacity(.05),
              borderRadius: _borderRadius,
            ),
            child: ClipRRect(
              borderRadius: _borderRadius,
              child: Stack(
                children: <Widget>[
                  ..._loginImage(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ..._registerFrom(),
                        _otherReg(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _login() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('欢迎来到 微聊', style: _headText),
          Text('超级坑', style: _descText),
          SizedBox(height: 60),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: _theme.primaryColorDark.withOpacity(.05),
              borderRadius: _borderRadius,
            ),
            child: ClipRRect(
              borderRadius: _borderRadius,
              child: Stack(
                children: <Widget>[
                  ..._loginImage(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ..._loginFrom(),
                        _other(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _loginImage() {
    return <Widget>[
      Positioned(
        bottom: -40,
        right: 0,
        child: Image.asset('images/login_bottom.png', width: 220, height: 220),
      ),
      Positioned(
        left: 0,
        top: -10,
        child: Image.asset('images/signup_top.png', width: 120, height: 120),
      ),
    ];
  }

  Widget _other() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text('忘记密码?'),
          ),
          GestureDetector(
            child: Text('账号注册'),
            onTap: () =>
                setState(() => _crossFadeState = CrossFadeState.showSecond),
          ),
        ],
      ),
    );
  }

  Widget _otherReg() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Expanded(child: SizedBox()),
          GestureDetector(
            child: Text('账号登录'),
            onTap: () =>
                setState(() => _crossFadeState = CrossFadeState.showFirst),
          ),
        ],
      ),
    );
  }

  get _dataLoginLength =>
      _dataLogin['username'].trim().length > 0 &&
      _dataLogin['password'].trim().length > 0;

  get _dataRegisterLength =>
      _dataRegister['nickname'].trim().length > 0 &&
      _dataRegister['username'].trim().length > 0 &&
      _dataRegister['password'].trim().length > 0 &&
      _dataRegister['passwordNew'].trim().length > 0;

  List<Widget> _registerFrom() {
    return <Widget>[
      RoundedInputField(
        enabled: !loading,
        icon: ChatIcon.jiaban,
        focusNode: nickname,
        hintText: "请输入昵称",
        onChanged: (value) => setState(() => _dataRegister['nickname'] = value),
        onSubmitted: (value) {
          nickname.unfocus();
          FocusScope.of(context).requestFocus(regUsername);
        },
      ),
      RoundedInputField(
        enabled: !loading,
        focusNode: regUsername,
        hintText: "请输入账号",
        onChanged: (value) => setState(() => _dataRegister['username'] = value),
        onSubmitted: (value) {
          regUsername.unfocus();
          FocusScope.of(context).requestFocus(regPassword);
        },
      ),
      RoundedPasswordField(
        enabled: !loading,
        focusNode: regPassword,
        obscureText: obscureText1,
        hintText: "请输入密码",
        onChanged: (value) => setState(() => _dataRegister['password'] = value),
        onVisibility: () => setState(() => obscureText1 = !obscureText1),
        onSubmitted: (value) {
          regPassword.unfocus();
          FocusScope.of(context).requestFocus(regPasswordNew);
        },
      ),
      RoundedPasswordField(
        enabled: !loading,
        focusNode: regPasswordNew,
        obscureText: obscureText2,
        hintText: "请再次输入密码",
        onChanged: (value) =>
            setState(() => _dataRegister['passwordNew'] = value),
        onVisibility: () => setState(() => obscureText2 = !obscureText2),
      ),
      SizedBox(height: 10),
      Center(
        child: RoundedButton(
          enabled: !_dataRegisterLength,
          loading: loading,
          text: "注册",
          press: onLogin,
        ),
      ),
    ];
  }

  List<Widget> _loginFrom() {
    return <Widget>[
      RoundedInputField(
        enabled: !loading,
        focusNode: username,
        hintText: "请输入账号",
        onChanged: (value) => setState(() => _dataLogin['username'] = value),
        onSubmitted: (value) {
          username.unfocus();
          FocusScope.of(context).requestFocus(password);
        },
      ),
      RoundedPasswordField(
        enabled: !loading,
        focusNode: password,
        obscureText: obscureText,
        hintText: "请输入密码",
        onChanged: (value) => setState(() => _dataLogin['password'] = value),
        onVisibility: () => setState(() => obscureText = !obscureText),
      ),
      SizedBox(height: 10),
      Center(
        child: RoundedButton(
          enabled: !_dataLoginLength,
          loading: loading,
          text: "登录",
          press: onLogin,
        ),
      ),
    ];
  }

  void onLogin() async {
    setState(() => loading = true);
    bool status =
        await Provider.of<UserProvider>(context, listen: false).userLogin(
      username: _dataLogin['username'],
      password: _dataLogin['password'],
    );
    setState(() => loading = false);
    if (status) {
      String token = await PreferenceTool.loadData('Authorization');
      socketEventBus.fire(SocketConnectEvent(token));
      Navigator.pop(context);
    }
  }
}
