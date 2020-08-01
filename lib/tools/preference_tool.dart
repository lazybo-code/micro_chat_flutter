import 'package:shared_preferences/shared_preferences.dart';

class PreferenceTool {
  // 存储数据
  static Future<bool> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    //setValue
    return prefs.setString(key, value);
  }

  // 读取数据
  static Future<String> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    //getValue default 0
    return prefs.getString(key) ?? null;
  }

  // 删除数据
  static Future<bool> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('counter');
  }
}
