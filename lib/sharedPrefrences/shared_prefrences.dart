import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  static Future<bool> setUserDetails(Map<String, dynamic> userDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDetailsString = jsonEncode(userDetails);
    bool isSaved = await prefs.setString("userDetails", userDetailsString);
    return isSaved;
  }

  static Future<Map<String, dynamic>?> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDetails = prefs.getString("userDetails");

    if (userDetails != null && userDetails.isNotEmpty) {
      return jsonDecode(userDetails);
    } else {
      return null;
    }
  }

  static Future<bool> removeUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("userDetails");
  }
}
