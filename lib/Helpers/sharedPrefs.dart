import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String pageIndex = "PAGEINDEX";

  Future<String?> getcurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }
}
