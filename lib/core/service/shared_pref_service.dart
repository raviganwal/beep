import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String token = "com.beep.token";
  static const String verificationToken = "com.beep.verification_token";
  static const String resendToken = "com.beep.resend_token";

  Future<void> setBoolKey({required String key, required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> getBoolKey(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? false;
  }

  Future<void> setStringKey(
      {required String key, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getStringKey({required String key, required String defValue}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? defValue;
  }
}
