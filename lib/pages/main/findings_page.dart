import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:micro_chat/components/menu_list.dart';
import 'package:micro_chat/icon/chat_icon.dart';
import 'package:micro_chat/tools/basis_tool.dart';

class FindingsPage extends StatefulWidget {
  FindingsPage({Key key}) : super(key: key);

  @override
  _FindingsPageState createState() => _FindingsPageState();
}

class _FindingsPageState extends State<FindingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            MenuListIcon(child: [
              MenuListIconItem(ChatIcon.panYuQuan, '朋友圈'),
            ]),
            SizedBox(height: 15),
            MenuListIcon(
              child: [
                MenuListIconItem(ChatIcon.saoMiao, '扫一扫'),
              ],
              onTap: (_) async {
                if (await BasisTool.permissionCameraApply()) {
                  var result = await BarcodeScanner.scan(
                    options: ScanOptions(
                      strings: {
                        'cancel': '取消',
                        'flash_on': '打开闪光灯',
                        'flash_off': '关闭闪光灯'
                      }
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
