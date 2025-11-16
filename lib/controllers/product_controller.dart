import 'package:get/get.dart';
import '../data/api_service.dart';
import '../models/product.dart';

class ProductController extends GetxController {
  final ApiService apiService = ApiService();

  var products = <Product>[].obs;
  var isLoading = false.obs;

  // Ambil produk via HTTP
  void getProductsUsingHttp() async {
    try {
      isLoading(true);
      final result = await apiService.fetchProductsWithHttp();
      products.assignAll(result);
      Get.snackbar('HTTP', 'Berhasil ambil data via HTTP');
    } catch (e) {
      Get.snackbar('Error', 'Gagal ambil data via HTTP: $e');
    } finally {
      isLoading(false);
    }
  }

  // Ambil produk via Dio
  void getProductsUsingDio() async {
    try {
      isLoading(true);
      final result = await apiService.fetchProductsWithDio();
      products.assignAll(result);
      Get.snackbar('Dio', 'Berhasil ambil data via Dio');
    } catch (e) {
      Get.snackbar('Error', 'Gagal ambil data via Dio: $e');
    } finally {
      isLoading(false);
    }
  }

  // Eksperimen async–await
  Future<void> fetchChainedAsync() async {
    isLoading(true);
    await apiService.fetchChainedAsync();
    isLoading(false);
    Get.snackbar('Async-Await', 'Percobaan async-await selesai, lihat terminal.');
  }

  // Eksperimen callback chaining
  Future<void> fetchChainedCallback() async {
    isLoading(true);
    await apiService.fetchChainedCallback();
    isLoading(false);
    Get.snackbar('Callback', 'Percobaan callback chaining selesai, lihat terminal.');
  }
}

  

