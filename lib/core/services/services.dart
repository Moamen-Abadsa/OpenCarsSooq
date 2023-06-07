import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_options.dart';

class AppServices extends GetxService {

  late SharedPreferences sharedPreferences;

  Future<AppServices> init() async {
      sharedPreferences = await SharedPreferences.getInstance();
      return this;
  }

  int getIntSharedPreferences(String key) {
    return sharedPreferences.getInt(key) ?? 0;
  }

  String getStringSharedPreferences(String key) {
    return sharedPreferences.getString(key) ?? '';
  }

  bool getBoolSharedPreferences(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

}

initialServices() async {
  await Get.putAsync(() => AppServices().init());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}