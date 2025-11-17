import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// CONTROLLER
import 'controllers/cart_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/product_controller.dart';

// SERVICES
import 'services/hive_service.dart';
import 'services/supabase_service.dart';
import 'services/shared_prefs_service.dart';

// PAGES
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/product_list_page.dart';
import 'views/product_view.dart';
import 'pages/notes_page.dart';
import 'pages/note_edit_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Init services
  await SharedPrefsService.init();
  await HiveService.init();
  await SupabaseService.init();

  // 🔹 Register GetX controllers
  Get.put(CartController());
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(ProductController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeC = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Toko Rian Farah',

        // 🔹 Tema dari SharedPreferences
        themeMode: themeC.isDark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ),

        // 🔥 Redirect jika belum login
        initialRoute: (Supabase.instance.client.auth.currentUser == null)
            ? '/login'
            : '/',

        getPages: [
          // Auth Pages
          GetPage(name: '/login', page: () => LoginPage()),
          GetPage(name: '/register', page: () => RegisterPage()),

          // Main App
          GetPage(name: '/', page: () => const HomePage()),
          GetPage(name: '/cart', page: () => const CartPage()),
          GetPage(
            name: '/material',
            page: () => const ProductListPage(category: 'material'),
          ),
          GetPage(
            name: '/sembako',
            page: () => const ProductListPage(category: 'sembako'),
          ),
          GetPage(name: '/experiment', page: () => ProductView()),

          // Notes CRUD
          GetPage(name: '/notes', page: () => const NotesPage()),
          GetPage(name: '/note-edit', page: () => const NoteEditPage()),
        ],
      );
    });
  }
}
