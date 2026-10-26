
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static final Box box = Hive.box('authBox');

  static Future<void> setToken(String token) async {
    await box.put('token', token);
  }

  static String? getToken() {
    return box.get('token') as String?;
  }

  static Future<void> deleteToken() async {
    await box.delete('token');
  }

  static bool hasToken() {
    return getToken() != null;
  }
}
