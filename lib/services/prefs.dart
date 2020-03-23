import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences prefs;
  static List<String> suggestions = [];
  static List<String> tipsuggestions = [];
  static List<String> assignmentSuggestions = [];

  static Future initilize() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print("${e.toString()}");
    }
  }

  static Future setUserLoggedIn(bool status) async {
    prefs.setBool("status", status);
  }

    static bool getUserLoggedIn() {
    bool status = prefs.getBool("status");
    return status;
  }
}