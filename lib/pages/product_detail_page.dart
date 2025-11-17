import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../controllers/cart_controller.dart';
import 'cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final cart = Get.find<CartController>();
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final totalPrice =
        'Rp ${(widget.product.price * quantity).toStringAsFixed(0)}';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          widget.product.name,
          style: const TextStyle(color: Colors.black87, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.product.id,
              child: Image.asset(
                widget.product.image,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    totalPrice,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),

                  const Text(
                    "Deskripsi Produk",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Text("Jumlah:  "),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                      ),
                      Text(quantity.toString(),
                          style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() => quantity++);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  cart.addToCart(widget.product, qty: quantity);

                  Get.snackbar(
                    "Sukses",
                    "Produk ditambahkan ke keranjang",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text("Masukkan Keranjang"),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  cart.addToCart(widget.product, qty: quantity);
                  Get.to(() => const CartPage());
                },
                child: const Text("Beli Sekarang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
