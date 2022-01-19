import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  //sharedPrefs keys
  static const String _userId = "__USER_ID__";
  static const String _userName = "__USER_NAME__";
  static const String _displayName = "__DISPLAY_NAME__";
  static const String _userImage = "__USER_IMAGE__";
  static const String _token = "__TOKEN__";
  static const String _isLoggedIn = "__IsLoggedIn__";
  static const String _isFirstTime = "__IsFirstTime__";

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static setUserID(String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userId, id);
  }

  static Future<String> getUserID() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_userId) ?? "";
  }

  static setUserName(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userName, cookie);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_userName) ?? "";
  }

  static setDisplayName(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_displayName, cookie);
  }

  static Future<String> getDisplayName() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_displayName) ?? "";
  }

  static setUserImage(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userImage, cookie);
  }

  static Future<String> getUserImage() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_userImage) ?? "";
  }

  static setUserToken(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_token, cookie);
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_token) ?? "";
  }

  static setLoginSession(bool cookie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedIn, cookie);
  }

  static Future<bool> getLoginSession() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(_isLoggedIn) ?? false;
  }

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await _prefs;
    var isFirstTime = prefs.getBool(_isFirstTime);
    if (isFirstTime != null && !isFirstTime) {
      //Not first time.
      prefs.setBool(_isFirstTime, false);
      return false;
    } else {
      // First time.
      prefs.setBool(_isFirstTime, false);
      return true;
    }
  }
}
