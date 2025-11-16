import 'package:flutter/material.dart';
import 'product_list_page.dart';
import 'cart_page.dart';
import '../cart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  ).then((_) => (context as Element).reassemble());
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth > 800 ? 350 : 300;

         return Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
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

      const SizedBox(height: 40),

      // 🔹 Tombol untuk menuju halaman Eksperimen HTTP vs Dio
      ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/experiment');
        },
        icon: const Icon(Icons.science),
        label: const Text('Eksperimen HTTP vs Dio'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  ),
);

        },
      ),
    );
  }
}

class _CategoryCard extends StatefulWidget {
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
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool isHovering = false;
  bool isPressed = false; // untuk HP

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _onHover(bool hover) {
    setState(() {
      isHovering = hover;
    });
    if (hover) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS;

    return MouseRegion(
      onEnter: (_) => !isMobile ? _onHover(true) : null,
      onExit: (_) => !isMobile ? _onHover(false) : null,
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductListPage(category: widget.category),
            ),
          );
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isHovering ? _scaleAnimation.value : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isPressed
                      ? Colors.black.withOpacity(0.1) // efek redup saat ditekan
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    if (isHovering)
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                  ],
                ),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: isHovering ? 8 : 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    splashColor: Colors.blue.withOpacity(0.2), // ripple
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductListPage(category: widget.category),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: widget.cardWidth,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.asset(
                              widget.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
