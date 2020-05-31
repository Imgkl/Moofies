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

  static Future setTrendingTab(bool tabStatus) async {
    prefs.setBool("trending", tabStatus);
  }

  static bool getUserLoggedIn() {
    bool status =
        prefs.getBool("status") != null ? prefs.getBool("status") : false;
    return status;
  }

  static bool getTrendingTab() {
    bool status =
        prefs.getBool("trending") != null ? prefs.getBool("trending") : false;
    return status;
  }
}
