import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  //sharedPrefs keys
  static const String _USER_ID      = "__USER_ID__";
  static const String _USER_NAME    = "__USER_NAME__";
  static const String _DISPLAY_NAME = "__DISPLAY_NAME__";
  static const String _USER_IMAGE   = "__USER_IMAGE__";
  static const String _TOKEN        = "__TOKEN__";
  static const String _IsLoggedIn   = "__IsLoggedIn__";
  static const String _IsFirstTime  = "__IsFirstTime__";

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static setUserID(String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_USER_ID, id);
  }

  static Future<String> getUserID() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_USER_ID) ?? "";
  }

  static setUserName(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_USER_NAME, cookie);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_USER_NAME) ?? "";
  }

  static setDisplayName(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_DISPLAY_NAME, cookie);
  }

  static Future<String> getDisplayName() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_DISPLAY_NAME) ?? "";
  }

  static setUserImage(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_USER_IMAGE, cookie);
  }

  static Future<String> getUserImage() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_USER_IMAGE) ?? "";
  }

  static setUserToken(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_TOKEN, cookie);
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_TOKEN) ?? "";
  }

  static setLoginSession(bool cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_IsLoggedIn, cookie);
  }

  static Future<bool> getLoginSession() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(_IsLoggedIn) ?? false;
  }

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await _prefs;
    var isFirstTime = prefs.getBool(_IsFirstTime);
    if (isFirstTime != null && !isFirstTime) {
      //Not first time.
      prefs.setBool(_IsFirstTime, false);
      return false;
    } else {
      // First time.
      prefs.setBool(_IsFirstTime, false);
      return true;
    }
  }
}
