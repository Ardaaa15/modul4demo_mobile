import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../cart.dart';
import 'cart_page.dart';

class ProductListPage extends StatefulWidget {
  final String category;
  const ProductListPage({super.key, required this.category});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 🔹 Inisialisasi animasi
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Jalankan animasi setelah build pertama
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
    final filteredProducts =
        demoProducts.where((p) => p.category == widget.category).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.category == 'material' ? 'Material Bangunan' : 'Sembako',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  ).then((_) => setState(() {}));
                },
              ),
              if (Cart().items.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      Cart().items.length.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],

      // 🔹 Gunakan SafeArea + SingleChildScrollView biar gak overflow
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // 🔹 Responsif: jumlah kolom berubah sesuai lebar layar
              int crossAxisCount = constraints.maxWidth > 1200
                  ? 4
                  : constraints.maxWidth > 800
                      ? 3
                      : constraints.maxWidth > 500
                          ? 2
                          : 1;

              return filteredProducts.isEmpty
                  ? const Center(
                      child: Text('Produk belum tersedia.'),
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredProducts.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final delay = index * 0.1;

                        return AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            final opacity = Tween(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _controller,
                                curve: Interval(delay, 1.0,
                                    curve: Curves.easeIn),
                              ),
                            );

                            final scale = Tween(begin: 0.9, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _controller,
                                curve: Interval(delay, 1.0,
                                    curve: Curves.easeOutBack),
                              ),
                            );

                            return FadeTransition(
                              opacity: opacity,
                              child: ScaleTransition(
                                scale: scale,
                                child: ProductCard(
                                  product: filteredProducts[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
