import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/cart_provider.dart';
import 'services/preferences_service.dart';
import 'services/hive_service.dart';
import 'services/supabase_service.dart';

import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/product_list_page.dart';
import 'views/product_view.dart';

// Pages untuk modul eksplorasi
import 'pages/notes_page.dart';
import 'pages/note_edit_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Init SharedPreferences (tema aplikasi)
  await PreferencesService.init();

  // 🔹 Init Hive (data lokal)
  await HiveService.init();

  // 🔹 Init Supabase
  await SupabaseService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Rian Farah',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),

      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/cart', page: () => const CartPage()),
        GetPage(name: '/material',
            page: () => const ProductListPage(category: 'material')),
        GetPage(name: '/sembako',
            page: () => const ProductListPage(category: 'sembako')),
        GetPage(name: '/experiment', page: () => ProductView()),

        // 🔹 Routing baru untuk fitur Notes (modul eksplorasi)
        GetPage(name: '/notes', page: () => const NotesPage()),
        GetPage(name: '/note-edit', page: () => const NoteEditPage()),
      ],
    );
  }
}
