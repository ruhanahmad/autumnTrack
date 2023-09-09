import 'package:autumntrackmanagers/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<void> savePassword(String password, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'password',
      password,
    );
    await prefs.setString('email', email);
  }

  static Future<void> saveBiometricStatus(bool isBiometricEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      'isBiometricEnabled',
      isBiometricEnabled,
    );
  }

  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  static Future<bool> getBiometricStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isBiometricEnabled') ?? true;
  }

  static Future<String?> getemail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}
