import 'package:shared_preferences/shared_preferences.dart';

class dataIO {
  static late SharedPreferences _preferences;

  static const _keyUserName1 = "userName1";
  static const _keyUserName2 = "userName2";
  static const _firstTime = "firstTime";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserName1(String userName) async => await _preferences
      .setString(_keyUserName1, userName != "" ? userName : "Player 1");

  static Future setUserName2(String userName) async => await _preferences
      .setString(_keyUserName2, userName != "" ? userName : "Player 2");

  static Future getUserName1() async =>
      await _preferences.getString(_keyUserName1);

  static Future getUserName2() async =>
      await _preferences.getString(_keyUserName2);

  static Future firstTimeSet() async {
    await _preferences.setBool(_firstTime, false);
  }

  static Future firstTimeGet() async => await _preferences.getBool(_firstTime);
}
