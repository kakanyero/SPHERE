import 'package:flutter/material.dart';
import 'search_filters.dart';
import 'filter_screen.dart';

// TODO: replace this with your actual import, e.g.:
// import '../models/product.dart';
// import '../models/cart_model.dart';
// import '../widgets/product_card.dart';
//
// Product/CartModel below are lightweight stand-ins that mirror the fields
// mentioned in your existing product_data.dart / CartModel so this file
// compiles standalone. Delete these once wired to the real classes.

class Product {
  final String name;
  final double price;
  final String imagePath; // network URL or local asset path
  final String category;
  final String brand;
  final double rating;

  const Product({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.brand,
    this.rating = 0,
  });
}

class CartModel extends ChangeNotifier {
  CartModel._();
  static final CartModel instance = CartModel._();

  final List<Product> _items = [];
  List<Product> get items => _items;

  void addToCart(Product product) {
    _items.add(product);
    notifyListeners();
  }
}

/// Displays search results for [query], with a Filter button that opens
/// FilterScreen and applies the returned SearchFilters to the grid.
class SearchResultsScreen extends StatefulWidget {
  final String query;
  final SearchFilters initialFilters;

  const SearchResultsScreen({
    super.key,
    required this.query,
    required this.initialFilters,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late SearchFilters _filters;

  // TODO: replace with your real product list, e.g. `allProducts` from
  // product_data.dart, filtered by widget.query against name/category/brand.
  final List<Product> _allResults = [
    Product(
      name: 'Black T-Shirt',
      price: 29.99,
      imagePath: 'https://loremflickr.com/300/300/tshirt',
      category: 'Clothing',
      brand: 'Nike',
      rating: 4.5,
    ),
    Product(
      name: 'Logitech Headphone',
      price: 89.99,
      imagePath: 'https://loremflickr.com/300/300/headphone',
      category: 'Headphone',
      brand: 'Logitech',
      rating: 4.2,
    ),
    Product(
      name: 'White Sneakers',
      price: 59.99,
      imagePath: 'https://loremflickr.com/300/300/sneakers',
      category: 'Shoes',
      brand: 'Adidas',
      rating: 4.7,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filters = widget.initialFilters;
  }

  List<Product> get _filteredResults {
    var results = _allResults.where((p) {
      final matchesQuery =
          p.name.toLowerCase().contains(widget.query.toLowerCase());
      final matchesCategory =
          _filters.category == null || p.category == _filters.category;
      final matchesBrand = _filters.brand == null || p.brand == _filters.brand;
      final matchesPrice = p.price >= _filters.priceRange.start &&
          p.price <= _filters.priceRange.end;
      final matchesRating = p.rating >= _filters.minRating;
      return matchesQuery &&
          matchesCategory &&
          matchesBrand &&
          matchesPrice &&
          matchesRating;
    }).toList();

    switch (_filters.sortBy) {
      case 'Price: Low to High':
        results.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        results.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Newest':
        // TODO: sort by actual createdAt/dateAdded once available.
        break;
      default:
        // 'Popular' — TODO: sort by actual popularity/sales metric.
        break;
    }
    return results;
  }

  Future<void> _openFilters() async {
    final result = await Navigator.of(context).push<SearchFilters>(
      MaterialPageRoute(
        builder: (_) => FilterScreen(initialFilters: _filters),
      ),
    );
    if (result != null) {
      setState(() => _filters = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredResults;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          'Result For "${widget.query}"',
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${results.length} results found',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                TextButton.icon(
                  onPressed: _openFilters,
                  icon: const Icon(Icons.tune, size: 18),
                  label: Text(
                    _filters.isDefault
                        ? 'Filter'
                        : 'Filter (${_filters.activeCount})',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      'No products match your search',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final product = results[index];
                      return _ResultCard(
                        product: product,
                        onAddToCart: () {
                          CartModel.instance.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${product.name} added to cart')),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Card mirroring your existing ProductCard conventions:
/// Image.network vs Image.asset based on path prefix, cart icon beside
/// the name/price text block.
class _ResultCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const _ResultCard({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = product.imagePath.startsWith('http');

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: isNetworkImage
                  ? Image.network(product.imagePath, fit: BoxFit.cover)
                  : Image.asset(product.imagePath, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onAddToCart,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_shopping_cart,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
