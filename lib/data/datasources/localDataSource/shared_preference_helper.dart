import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferenceHelper {
  Future<String?> getEmail();
  Future<String?> getPassword();
  Future<void> setEmail(String email);
  Future<void> setPassword(String password);
  Future<bool> getOnboardingComplete();
  Future<void> saveOnboardingComplete();
}

class SharedPreferenceHelperImpl implements SharedPreferenceHelper {
  static const String emailKey = 'email';
  static const String passwordKey = 'password';
  static const String onboardingKey = 'onboarding';

  @override
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  @override
  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey);
  }

  @override
  Future<bool> getOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  @override
  Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
  }

  @override
  Future<void> setPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(passwordKey, password);
  }

  @override
  Future<void> saveOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, true);
  }
}
