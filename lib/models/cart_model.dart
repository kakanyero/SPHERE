import 'package:flutter/foundation.dart';
import 'product_data.dart';

/// One line item in the cart: a product plus quantity and any
/// selected variant (color/size).
class CartItem {
  final Product product;
  int quantity;
  final String? selectedColor;
  final String? selectedSize;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
  });

  double get subtotal => product.price * quantity;
}

/// App-wide cart, exposed via ChangeNotifier so Cart/Checkout/Home
/// (badge count) all stay in sync without extra plumbing.
/// Wrap your app in `ChangeNotifierProvider(create: (_) => CartModel())`
/// if you adopt `provider`, or read `CartModel.instance` directly.
class CartModel extends ChangeNotifier {
  CartModel._internal();
  static final CartModel instance = CartModel._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.subtotal);

  static const double shippingFee = 5.00;

  double get total => subtotal + (_items.isEmpty ? 0 : shippingFee);

  void addItem(Product product, {String? color, String? size, int quantity = 1}) {
    final existingIndex = _items.indexWhere((item) =>
        item.product.id == product.id &&
        item.selectedColor == color &&
        item.selectedSize == size);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(
        product: product,
        quantity: quantity,
        selectedColor: color,
        selectedSize: size,
      ));
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    if (quantity <= 0) {
      removeItem(item);
      return;
    }
    item.quantity = quantity;
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
