import 'package:anime_fandom/constants/hive_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  static final box = Hive.box('animeFandom');

  static Future setStringValue({required String key, required String value}) =>
      box.put(key, value);
  static Future setBoolValue({required String key, required bool value}) =>
      box.put(key, value);

  static bool? getValue(String hiveKey) => box.get(hiveKey);

  static String? getToken() => box.get(HiveKeys.token);
  static String? getUserId() => box.get(HiveKeys.userId);
  static String? getFirstName() => box.get(HiveKeys.firstName);
  static String? getLastName() => box.get(HiveKeys.lastName);
  static String? getEmail() => box.get(HiveKeys.email);
  static String? getPhoneNumber() => box.get(HiveKeys.phoneNumber);
  static bool? getIsUserActive() => box.get(HiveKeys.isUserActive);
  static bool? getIsUserExist() => box.get(HiveKeys.isUserExist);

  static Future clearHive() async {
    await box.clear();
  }
}
