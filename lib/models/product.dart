class Product {
  final String id;
  final String name;
  final String category; // 'material' atau 'sembako'
  final double price;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
  });
   factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? json['name'] ?? 'Tidak ada nama',
      category: json['category'] ?? 'tidak ada kategori',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      description: json['description'] ?? 'tidak ada deskripsi',
    );
  }
}




final List<Product> demoProducts = [
  // 🧱 MATERIAL BANGUNAN
  Product(
    id: 'm1',
    name: 'Semen Tiga Roda 40kg',
    category: 'material',
    price: 85000,
    image: 'assets/semen.jpg',
    description:
        'Semen berkualitas tinggi, cocok untuk berbagai jenis bangunan.',
  ),
  Product(
    id: 'm2',
    name: 'Besi Beton 12mm',
    category: 'material',
    price: 120000,
    image: 'assets/besi.jpg',
    description:
        'Besi beton kuat dan tahan lama untuk konstruksi rumah dan gedung.',
  ),
  Product(
    id: 'm3',
    name: 'Cat Tembok Dulux 5L',
    category: 'material',
    price: 180000,
    image: 'assets/cat_tembok.jpg',
    description:
        'Cat tembok berkualitas tinggi, hasil warna merata dan tahan lama.',
  ),
  Product(
    id: 'm4',
    name: 'Paku 1kg',
    category: 'material',
    price: 25000,
    image: 'assets/paku.jpg',
    description: 'Paku serbaguna untuk kebutuhan konstruksi dan kerajinan.',
  ),
  Product(
    id: 'm5',
    name: 'Keramik 40x40 cm',
    category: 'material',
    price: 120000,
    image: 'assets/keramik.jpg',
    description:
        'Keramik berkualitas dengan permukaan halus, cocok untuk lantai rumah.',
  ),
  Product(
    id: 'm6',
    name: 'Kayu Balok 2m',
    category: 'material',
    price: 75000,
    image: 'assets/kayu_balok.jpg',
    description: 'Kayu balok kokoh, ideal untuk rangka bangunan.',
  ),
  Product(
    id: 'm7',
    name: 'Triplek 4mm',
    category: 'material',
    price: 90000,
    image: 'assets/triplek.jpg',
    description: 'Triplek tipis namun kuat, cocok untuk furniture atau plafon.',
  ),
  Product(
    id: 'm8',
    name: 'Pasir 1 Truk',
    category: 'material',
    price: 950000,
    image: 'assets/pasir.jpg',
    description: 'Pasir bersih, siap pakai untuk konstruksi dan pengecoran.',
  ),
  Product(
    id: 'm9',
    name: 'Batu Bata 100pcs',
    category: 'material',
    price: 80000,
    image: 'assets/batu_bata.jpg',
    description: 'Batu bata berkualitas, ukuran seragam, mudah disusun.',
  ),
  Product(
    id: 'm10',
    name: 'Kawat Bendrat 1kg',
    category: 'material',
    price: 18000,
    image: 'assets/kawat_bendrat.jpg',
    description: 'Kawat bendrat serbaguna untuk kebutuhan konstruksi ringan.',
  ),

  // 🛒 SEMBAKO
  Product(
    id: 's1',
    name: 'Beras Ramos 5kg',
    category: 'sembako',
    price: 75000,
    image: 'assets/beras.jpg',
    description: 'Beras pulen berkualitas tinggi, cocok untuk konsumsi harian.',
  ),
  Product(
    id: 's2',
    name: 'Minyak Goreng 2L',
    category: 'sembako',
    price: 48000,
    image: 'assets/minyak_goreng.jpg',
    description:
        'Minyak goreng bersih dan sehat, ideal untuk memasak sehari-hari.',
  ),
  Product(
    id: 's3',
    name: 'Gula Pasir 1kg',
    category: 'sembako',
    price: 16000,
    image: 'assets/gula_pasir.jpg',
    description: 'Gula pasir putih berkualitas, manis dan mudah larut.',
  ),
  Product(
    id: 's4',
    name: 'Telur Ayam 1kg',
    category: 'sembako',
    price: 27000,
    image: 'assets/telur_ayam.jpg',
    description: 'Telur ayam segar, cocok untuk masakan dan konsumsi harian.',
  ),
  Product(
    id: 's5',
    name: 'Kopi Kapal Api 165g',
    category: 'sembako',
    price: 18000,
    image: 'assets/kopi.jpg',
    description: 'Kopi bubuk berkualitas, aroma khas dan nikmat diseduh.',
  ),
  Product(
    id: 's6',
    name: 'Susu Kental Manis 370g',
    category: 'sembako',
    price: 17000,
    image: 'assets/susu.jpg',
    description: 'Susu kental manis, rasa lezat untuk minuman atau olahan.',
  ),
  Product(
    id: 's7',
    name: 'Mie Instan 1 Dus',
    category: 'sembako',
    price: 110000,
    image: 'assets/mie.jpg',
    description: 'Mie instan siap saji, praktis dan nikmat.',
  ),
  Product(
    id: 's8',
    name: 'Tepung Terigu 1kg',
    category: 'sembako',
    price: 15000,
    image: 'assets/tepung.jpg',
    description:
        'Tepung terigu serbaguna untuk kue, roti, atau masakan lainnya.',
  ),
  Product(
    id: 's9',
    name: 'Garam Halus 500g',
    category: 'sembako',
    price: 5000,
    image: 'assets/garam.jpg',
    description: 'Garam halus berkualitas, menambah cita rasa masakan.',
  ),
  Product(
    id: 's10',
    name: 'Kecap Manis Bango 600ml',
    category: 'sembako',
    price: 28000,
    image: 'assets/kecap.jpg',
    description:
        'Kecap manis Bango, rasa legit dan cocok untuk berbagai masakan.',
  ),
];
