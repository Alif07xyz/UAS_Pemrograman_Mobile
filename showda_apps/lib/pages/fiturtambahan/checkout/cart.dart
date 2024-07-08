import 'package:showda_apps/model/produk.dart';

class CartItem {
  final Produk product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  List<CartItem> items = [];

  void addItem(Produk product) {
    for (var item in items) {
      if (item.product.id == product.id) {
        item.quantity++;
        return;
      }
    }
    items.add(CartItem(product: product));
  }

  void removeItem(Produk product) {
    items.removeWhere((item) => item.product.id == product.id);
  }

  void clearCart() {
    items.clear();
  }

  num getTotalPrice() {
    num total = 0;
    for (var item in items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
