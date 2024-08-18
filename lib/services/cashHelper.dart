import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  String token = CachHelper.getString(key: "token") ?? '';
  String email = CachHelper.getString(key: "email") ?? '';
  String password = CachHelper.getString(key: "password") ?? '';
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(
      {required String key, required String value}) async {
    await sharedPreferences?.setString(key, value);
  }

  static Future<void> setBool(
      {required String key, required bool value}) async {
    await sharedPreferences?.setBool(key, value);
  }

  static String? getString({required String key}) {
    return sharedPreferences?.getString(key);
  }

  static bool? getBool({required String key}) {
    return sharedPreferences?.getBool(key);
  }

  static Future<void> remove({required String key}) async {
    await sharedPreferences?.remove(key);
  }
}











// import 'package:shared_preferences/shared_preferences.dart';

// class CachHelper {
//   static SharedPreferences? sharedPreferences;
//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }

//   static setString({required String key, required String value}) async {
//     await sharedPreferences?.setString(key, value);
//   }

//   static setBool({required String key, required bool value}) async {
//     await sharedPreferences?.setBool(key, value);
//   }

//   static get({required String key}) {
//     return sharedPreferences?.get(key);
//   }
// }
