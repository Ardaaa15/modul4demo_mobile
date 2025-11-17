import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/theme_controller.dart';
import 'product_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeC = Get.find<ThemeController>();
    final cart = Get.find<CartController>();

    final categories = [
      {
        'title': 'Material Bangunan',
        'image': 'assets/material.jpg',
        'category': 'material',
      },
      {
        'title': 'Sembako',
        'image': 'assets/sembako.jpg',
        'category': 'sembako',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Toko Rian Farah',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Obx(() => IconButton(
                icon: Icon(themeC.isDark ? Icons.dark_mode : Icons.light_mode),
                onPressed: () => themeC.toggleTheme(),
              )),
          Obx(() => Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => Get.toNamed('/cart'),
                  ),
                  if (cart.count > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cart.count}',
                          style: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              )),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth > 800 ? 350 : 300;
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: categories.map((cat) {
                      return _CategoryCard(
                        title: cat['title']!,
                        image: cat['image']!,
                        category: cat['category']!,
                        cardWidth: cardWidth,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  // Tombol akses Notes
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/notes'),
                    icon: const Icon(Icons.note),
                    label: const Text('Buka Catatan'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final String category;
  final double cardWidth;

  const _CategoryCard({
    required this.title,
    required this.image,
    required this.category,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductListPage(category: category)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: cardWidth,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(image, fit: BoxFit.cover, width: double.infinity),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
