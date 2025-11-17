import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // LOGIN
  Future<void> login(String email, String password) async {
    try {
      isLoading(true);

      final result = await AuthService.login(email, password);

      if (result.user != null) {
        Get.offAllNamed('/'); // pindah ke Home
        Get.snackbar("Sukses", "Berhasil login!");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // REGISTER
  Future<void> register(String email, String password) async {
    try {
      isLoading(true);

      final result = await AuthService.register(email, password);

      if (result.user != null) {
        Get.offAllNamed('/login');
        Get.snackbar("Sukses", "Akun berhasil dibuat. Silakan login.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await AuthService.logout();
    Get.offAllNamed('/login');
  }
}
