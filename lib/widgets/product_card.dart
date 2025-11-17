import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../controllers/cart_controller.dart';
import '../pages/product_detail_page.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween(begin: 0.9, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final p = widget.product;

    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailPage(product: p));
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // HERO untuk animasi ke halaman detail
              Hero(
                tag: p.id,
                child: Image.asset(
                  p.image,
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  p.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),

              Text(
                "Rp ${p.price}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      cart.addToCart(p, qty: 1);
                      Get.snackbar(
                        "Berhasil",
                        "${p.name} ditambahkan ke keranjang",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: const Text(
                      "Tambah",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
