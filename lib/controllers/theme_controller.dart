import 'package:get/get.dart';
import '../services/shared_prefs_service.dart';

class ThemeController extends GetxController {
  final _isDark = false.obs;

  bool get isDark => _isDark.value;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi dari SharedPreferences
    _isDark.value = SharedPrefsService.getIsDarkMode();
  }

  Future<void> toggleTheme() async {
    _isDark.value = !_isDark.value;
    await SharedPrefsService.setIsDarkMode(_isDark.value);
    // jika mau, notifikasi atau logic lain bisa ditaruh di sini
  }

  Future<void> setDark(bool value) async {
    _isDark.value = value;
    await SharedPrefsService.setIsDarkMode(value);
  }
}
