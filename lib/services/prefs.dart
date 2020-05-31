import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences prefs;

  static Future initilize() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print("${e.toString()}");
    }
  }

  static Future setUserLoggedIn(bool loginStatus) async {
    prefs.setBool("status", loginStatus);
  }

  static Future setEmail(String emailID) async {
    prefs.setString("email", emailID);
  }

  static Future setUID(String uid) async {
    prefs.setString("uid", uid);
  }

  static Future setTrendingTab(bool tabStatus) async {
    prefs.setBool("trending", tabStatus);
  }

  static bool getUserLoggedIn() {
    bool status =
        prefs.getBool("status") != null ? prefs.getBool("status") : false;
    return status;
  }

  static bool getTrendingTab() {
    bool trending =
        prefs.getBool("trending") != null ? prefs.getBool("trending") : false;
    return trending;
  }

  static String getEmailID() {
    String email =
        prefs.getString("email") != null ? prefs.getString("email") : "";
    return email;
  }

  static String getUID() {
    String uid = prefs.getString("uid") != null ? prefs.getString("uid") : "";
    return uid;
  }
}
