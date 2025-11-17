import 'package:get/get.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int qty;

  CartItem({required this.product, required this.qty});
}

class CartController extends GetxController {
  var items = <CartItem>[].obs;

  void addToCart(Product product, {int qty = 1}) {
    final index =
        items.indexWhere((element) => element.product.id == product.id);

    if (index != -1) {
      items[index].qty += qty;
    } else {
      items.add(CartItem(product: product, qty: qty));
    }

    items.refresh();
  }

  void removeItem(Product product) {
    items.removeWhere((e) => e.product.id == product.id);
  }

  int get count =>
      items.fold(0, (sum, item) => sum + item.qty);

  double get totalPrice => items.fold(
      0, (sum, item) => sum + (item.product.price * item.qty));
}
