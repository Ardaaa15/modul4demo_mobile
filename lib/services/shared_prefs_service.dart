import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const _keyIsDarkMode = 'is_dark_mode';
  static const _keyHasSeenOnboarding = 'has_seen_onboarding';

  static SharedPreferences? _prefs;

  // Inisialisasi sekali saat app start
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // THEME
  static bool getIsDarkMode() {
    return _prefs?.getBool(_keyIsDarkMode) ?? false;
  }

  static Future<void> setIsDarkMode(bool value) async {
    await _prefs?.setBool(_keyIsDarkMode, value);
  }

  // ONBOARDING FLAG (contoh lain)
  static bool getHasSeenOnboarding() {
    return _prefs?.getBool(_keyHasSeenOnboarding) ?? false;
  }

  static Future<void> setHasSeenOnboarding(bool value) async {
    await _prefs?.setBool(_keyHasSeenOnboarding, value);
  }
}
