import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String pageIndex = "PAGEINDEX";
  Future<String?> getcurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }

  int? getFromLocalCache(SharedPreferences sharedPreferences, String key) {
    try {
      return sharedPreferences.getInt(key);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> removeFromLocalCache(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  Future<void> saveToLocalCache({required String key, required value}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setInt(key, value);
  }
}

// Future<void>? populateLocalWatchList() {
//   if (SharedPreferenceHelper().getFromLocalCache(canavar) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: canavar, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(cruella) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: cruella, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(avatar) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: avatar, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(thor) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: thor, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(vikram) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: vikram, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(eternals) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: eternals, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(aI) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: aI, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(smile) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: smile, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(goodLife) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: goodLife, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(tronLegacy) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: tronLegacy, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(nope) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: nope, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(spectre) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: spectre, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(theDarkKnightRises) == null) {
//     SharedPreferenceHelper()
//         .saveToLocalCache(key: theDarkKnightRises, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(fastandFurious9) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: fastandFurious9, value: 0);
//   }
//   if (SharedPreferenceHelper().getFromLocalCache(dune) == null) {
//     SharedPreferenceHelper().saveToLocalCache(key: dune, value: 0);
//   }
//   return null;
// }
