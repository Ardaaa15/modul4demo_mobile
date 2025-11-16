import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang & Panduan Uji')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text('Panduan pengujian (sesuai Modul 2):', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('1. Uji responsivitas di berbagai ukuran layar.'),
            Text('2. Perhatikan perubahan layout via MediaQuery & LayoutBuilder.'),
            Text('3. Lihat animasi implisit (ikon hati).'),
            Text('4. Lihat animasi eksplisit (gambar di halaman detail).'),
            Text('5. Profiling animasi via Flutter DevTools tab Performance.'),
            SizedBox(height: 12),
            Text('Catatan: Tambahkan produk baru di file models/product.dart.'),
          ],
        ),
      ),
    );
  }
}
