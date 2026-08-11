/// Simple product model used across Home, Product Details, Cart,
/// Wishlist and Search screens.
class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final double? oldPrice;
  final String category;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> colors;
  final List<String> sizes;

  const Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.oldPrice,
    required this.category,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
        'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    this.colors = const [],
    this.sizes = const [],
  });
}

const List<String> categories = [
  'All',
  'Clothing',
  'Electronics',
  'Beauty',
  'Shoes',
];

const List<Product> sampleProducts = [
  Product(
    id: 'p1',
    name: 'Black T-Shirt',
    image: 'assets/images/products/black_tshirt.png',
    price: 29.99,
    oldPrice: 39.99,
    category: 'Clothing',
    rating: 4.5,
    reviewCount: 267,
    colors: ['Black', 'White', 'Grey'],
    sizes: ['S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'p2',
    name: 'Basic Shirt',
    image: 'assets/images/products/basic_shirt.png',
    price: 39.99,
    category: 'Clothing',
    rating: 4.2,
    reviewCount: 89,
  ),
  Product(
    id: 'p3',
    name: 'Sneakers',
    image: 'assets/images/products/sneakers.png',
    price: 59.99,
    category: 'Shoes',
    rating: 4.7,
    reviewCount: 154,
  ),
  Product(
    id: 'p4',
    name: 'Logitech Headphone',
    image: 'assets/images/products/headphone.png',
    price: 137.00,
    category: 'Electronics',
    rating: 4.6,
    reviewCount: 302,
  ),
  Product(
    id: 'p5',
    name: 'Backpack',
    image: 'assets/images/products/backpack.png',
    price: 49.99,
    category: 'Clothing',
    rating: 4.3,
    reviewCount: 71,
  ),
  Product(
    id: 'p6',
    name: 'Wireless Earbuds',
    image: 'assets/images/products/earbuds.png',
    price: 27.99,
    category: 'Electronics',
    rating: 4.1,
    reviewCount: 45,
  ),
];
