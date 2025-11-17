import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cart = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Belanja"),
      ),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return const Center(
            child: Text(
              "Keranjang kosong",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final item = cart.items[index];

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Image.asset(
                    item.product.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.product.name),
                  subtitle: Text("Rp ${item.product.price} x ${item.qty}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      cart.removeItem(item.product);
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.blue.shade50,
          child: Text(
            "Total: Rp ${cart.totalPrice}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }
}
