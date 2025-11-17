import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  final String category;
  const ProductListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final ProductController productController = Get.find<ProductController>();

    // Ambil produk sesuai kategori dari demoProducts
    final List<Product> products =
        demoProducts.where((p) => p.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori: $category"),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_download),
            onPressed: () {
              Get.defaultDialog(
                title: 'Eksperimen Ambil Data',
                content: Column(
                  children: [
                    ElevatedButton(
                      onPressed: productController.getProductsUsingHttp,
                      child: const Text('HTTP'),
                    ),
                    ElevatedButton(
                      onPressed: productController.getProductsUsingDio,
                      child: const Text('Dio'),
                    ),
                    ElevatedButton(
                      onPressed: productController.fetchChainedAsync,
                      child: const Text('Async-Await'),
                    ),
                    ElevatedButton(
                      onPressed: productController.fetchChainedCallback,
                      child: const Text('Callback Chaining'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return GestureDetector(
            onTap: () {
              // buka halaman detail produk
              Get.to(() => ProductDetailPage(product: product));
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(product.image, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Rp ${product.price}",
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        cartController.addToCart(product);
                        Get.snackbar(
                          'Berhasil',
                          '${product.name} ditambahkan ke keranjang',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: const Text("Tambah ke Keranjang"),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () {
            // buka halaman keranjang
            Get.toNamed('/cart'); // pastikan route '/cart' sudah ada
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.shopping_cart),
              if (cartController.count > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartController.count}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
