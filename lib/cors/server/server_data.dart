import 'package:shared_preferences/shared_preferences.dart';

class ServerData {
  ServerData._();
  static ServerData? _instance;
  static ServerData get instance => _instance ??= ServerData._();

  Future<bool> setToken({required String token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString('_tokenKey', token);
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('_tokenKey') ?? '';
  }
  // static Future<bool> setPassword({required String password}) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return await pref.setString('_passwordKey', password);
  // }

  // static Future<String> getPassword() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return pref.getString('_passwordKey') ?? '';
  // }

  // static Future<bool> removePassword() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return await pref.remove('_passwordKey');
  // }

  // static Future<bool> setRemember({required bool remember}) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return await pref.setBool('_rememberKey', remember);
  // }

  // static Future<bool> getRemember() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return pref.getBool('_rememberKey') ?? false;
  // }
}
