import 'package:flutter/material.dart';
import 'package:micro_chat/provider/count_provider.dart';
import 'package:micro_chat/provider/friends_provider.dart';
import 'package:micro_chat/provider/message_provider.dart';
import 'package:micro_chat/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'pages/app.dart';
import 'tools/basis_tool.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  BasisTool.permissionMicrophoneApply();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: new CountProvider()),
        ChangeNotifierProvider.value(value: new UserProvider()),
        ChangeNotifierProvider.value(value: new FriendsProvider()),
        ChangeNotifierProvider.value(value: new MessageProvider()),
      ],
      child: App(),
    ),
  );
  BasisTool.setImmerse();
}