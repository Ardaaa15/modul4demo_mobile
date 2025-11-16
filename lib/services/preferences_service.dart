import 'package:shared_preferences/shared_preferences.dart';


class PreferencesService {
static SharedPreferences? _prefs;


static Future<void> init() async {
_prefs = await SharedPreferences.getInstance();
}


static Future<void> setDarkMode(bool value) async {
await _prefs?.setBool('isDark', value);
}


static bool isDarkMode() {
return _prefs?.getBool('isDark') ?? false;
}
}