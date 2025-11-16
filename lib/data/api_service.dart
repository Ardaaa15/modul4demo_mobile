import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/product.dart';

class ApiService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();
  final String baseUrl = 'https://fakestoreapi.com/products';

  // --- Menggunakan HTTP package ---
  Future<List<Product>> fetchProductsWithHttp() async {
    final stopwatch = Stopwatch()..start(); // Mulai hitung waktu
    try {
      final response = await http.get(Uri.parse(baseUrl));
      stopwatch.stop();
      _logger.i('HTTP Response Time: ${stopwatch.elapsedMilliseconds} ms');

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) {
          return Product(
            id: e['id'].toString(),
            name: e['title'],
            category: e['category'] ?? 'material',
            price: (e['price'] as num).toDouble(),
            image: e['image'],
            description: e['description'],
          );
        }).toList();
      } else {
        throw Exception('Gagal memuat data produk');
      }
    } catch (e) {
      stopwatch.stop();
      _logger.e('HTTP Error: $e');
      rethrow;
    }
  }

  // --- Menggunakan DIO ---
  Future<List<Product>> fetchProductsWithDio() async {
    final stopwatch = Stopwatch()..start(); // Mulai hitung waktu
    try {
      final response = await _dio.get(baseUrl);
      stopwatch.stop();
      _logger.i('Dio Response Time: ${stopwatch.elapsedMilliseconds} ms');

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) {
          return Product(
            id: e['id'].toString(),
            name: e['title'],
            category: e['category'] ?? 'material',
            price: (e['price'] as num).toDouble(),
            image: e['image'],
            description: e['description'],
          );
        }).toList();
      } else {
        throw Exception('Gagal memuat data produk');
      }
    } catch (e) {
      stopwatch.stop();
      _logger.e('Dio Error: $e');
      rethrow;
    }
  }

    // --- Eksperimen Async-Await ---
  Future<void> fetchChainedAsync() async {
    final stopwatch = Stopwatch()..start();
    print('🔹 Mulai Async-Await');

    try {
      final res1 = await _dio.get('$baseUrl/1');
      print('Produk pertama: ${res1.data['title']}');

      final res2 = await _dio.get('$baseUrl/2');
      print('Produk kedua: ${res2.data['title']}');

      stopwatch.stop();
      _logger.i('Async-Await Selesai dalam ${stopwatch.elapsedMilliseconds} ms');
    } catch (e) {
      _logger.e('Async-Await Error: $e');
    }
  }

  // --- Eksperimen Callback Chaining ---
  Future<void> fetchChainedCallback() {
    final stopwatch = Stopwatch()..start();
    print('🔸 Mulai Callback Chaining');

    return _dio.get('$baseUrl/1').then((res1) {
      print('Produk pertama: ${res1.data['title']}');
      return _dio.get('$baseUrl/2');
    }).then((res2) {
      print('Produk kedua: ${res2.data['title']}');
      stopwatch.stop();
      _logger.i('Callback Chaining Selesai dalam ${stopwatch.elapsedMilliseconds} ms');
    }).catchError((e) {
      _logger.e('Callback Chaining Error: $e');
    });
  }
}

  


 

