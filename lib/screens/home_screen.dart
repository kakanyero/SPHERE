import 'dart:async';
import 'package:flutter/material.dart'; // Imports Flutter’s Material Design widgets (Scaffold, Text, Container, etc.)
import '../../models/cart_model.dart'; // Imports the cart model (holds cart items and item count)
import '../../models/product_data.dart'; // Imports product-related data (Product class, sampleProducts list, categories list)
import '../../utils/app_theme.dart'; // Imports theme constants (AppColors, AppTextStyles)
import '../../widgets/product_card.dart'; // Imports the reusable product card widget
import 'cart_screen.dart'; // Imports the cart screen (for navigation)
import 'product_details_screen.dart'; // Imports the product details screen
import 'wishlist_screen.dart'; // Imports the wishlist screen

/// Page 12 — Home.
/// Location header, search bar, "New Collections 2024" banner, category
/// filter chips and a "Just For You" product grid.
class HomeScreen extends StatefulWidget {
  // Constructor. super.key passes the key to the parent StatefulWidget.
  // const allows compile-time constant creation.
  const HomeScreen({super.key});

  @override
  // Creates and returns the private state object _HomeScreenState
  State<HomeScreen> createState() => _HomeScreenState();
}

// Private state class that holds mutable data and builds the UI
class _HomeScreenState extends State<HomeScreen> {
  // Currently selected category filter. Starts as 'All'
  String _selectedCategory = 'All';

  // A set of product IDs the user has marked as favorite (local to this screen)
  final Set<String> _favoriteIds = {};

  // Getter that returns the list of products to display
  List<Product> get _filteredProducts {
    // If “All” is selected, return every product
    if (_selectedCategory == 'All') return sampleProducts;

    // Otherwise, filter products whose category matches the selected one
    // and convert the result to a list
    return sampleProducts
        .where((p) => p.category == _selectedCategory)
        .toList();
  }

  // Method that adds or removes a product from favorites
  void _toggleFavorite(String productId) {
    // Tells Flutter to rebuild the UI after the change
    setState(() {
      // Check if the product is already favorited
      if (_favoriteIds.contains(productId)) {
        // If yes → remove it (unfavorite)
        _favoriteIds.remove(productId);
      } else {
        // Otherwise add it (favorite)
        _favoriteIds.add(productId);
      }
    });
  }



// Add these at the top of your State class
late PageController _pageController;
int _currentPage = 0;
Timer? _timer;

@override
void initState() {
  super.initState();
  _pageController = PageController();

  // Auto-slide every 4 seconds
  _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
    if (_pageController.hasClients) {
      int nextPage = (_currentPage + 1) % 4; // 4 cards
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  });
}

@override
void dispose() {
  _timer?.cancel();
  _pageController.dispose();
  super.dispose();
}


  @override
  // Required method that returns the widget tree for this screen
  Widget build(BuildContext context) {
    // Root Material widget that provides the basic page structure
    return Scaffold(
      // Sets the page background color from the theme
      backgroundColor: AppColors.background,
      

      // Wraps content so it stays inside the safe area (avoids notch, status bar, etc.)
      body: SafeArea(
        // Rebuilds its child whenever the listened object changes
        child: AnimatedBuilder(
          // Listens to the global cart singleton.
          // When cart items change, this rebuilds.
          animation: CartModel.instance,

          // Builder function. _ is the unused child parameter.
          builder: (context, _) {
            // A scrollable view that uses slivers (efficient for mixed layouts)
            return CustomScrollView(
              slivers: [
                // Adds padding around a sliver
                SliverPadding(
                  // Left 20, Top 12, Right 20, Bottom 0
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),

                  // Converts a normal box widget into a sliver
                  sliver: SliverToBoxAdapter(
                    // Vertical layout of children
                    child: Column(
                      // Align children to the left
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Calls the header builder (location + cart icon)
                        _buildHeader(),

                        // Empty space of 20 pixels height
                        const SizedBox(height: 20),

                        // Search bar + wishlist button
                        _buildSearchBar(),

                        // Another 20-pixel gap
                        const SizedBox(height: 20),

                        // “NEW COLLECTIONS 2024” banner
                        _buildPromoCarousel(),
                        const SizedBox(height: 16),    

                        // Horizontal category filter chips
                        _buildCategoryChips(),

                        // 20-pixel gap
                        const SizedBox(height: 20),

                        // Horizontal layout for the “Just For You” title row
                        Row(
                          // Push children to opposite ends
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Static text widget
                            const Text(
                              'Just For You',
                              style: TextStyle(
                                fontSize: 16, // Font size 16
                                fontWeight: FontWeight.w700, // Bold weight
                                color: AppColors.textDark, // Dark text color from theme
                              ),
                            ),

                            // Makes its child tappable
                            GestureDetector(
                              // Currently does nothing (empty callback)
                              onTap: () {},
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 13, // Smaller font
                                  color: AppColors.primary, // Primary (brand) color
                                ),
                              ),
                            ),
                          ],
                        ),

                        // 12-pixel gap before the grid
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                // Padding around the grid
                SliverPadding(
                  // 20 pixels left and right
                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  // A grid that works as a sliver (scrolls with the rest of the page)
                  sliver: SliverGrid(
                    // Defines how the grid is laid out
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Exactly 2 columns
                      mainAxisSpacing: 16, // Vertical spacing between rows = 16
                      crossAxisSpacing: 16, // Horizontal spacing between columns = 16
                      childAspectRatio: 0.68, // Width / height ratio. 0.68 makes cards taller than wide
                    ),

                    // Builds children on demand (lazy loading)
                    delegate: SliverChildBuilderDelegate(
                      // Builder function for each item
                      (context, index) {
                        // Get the product at this index
                        final product = _filteredProducts[index];

                        // Create a product card widget
                        return ProductCard(
                          product: product, // Pass the product data
                          // Whether this product is currently favorited
                          isFavorite: _favoriteIds.contains(product.id),
                          // Callback when the heart is tapped
                          onFavoriteToggle: () => _toggleFavorite(product.id),
                          // When the card is tapped, push a new route
                          onTap: () => Navigator.of(context).push(
                            // Standard Material page transition
                            MaterialPageRoute(
                              // Build the details screen and pass the product
                              builder: (_) =>
                                  ProductDetailsScreen(product: product),
                            ),
                          ),
                        );
                      },
                      // How many items the grid should have
                      childCount: _filteredProducts.length,
                    ),
                  ),
                ),

                // Adds 24 pixels of empty space at the bottom of the scroll view
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          },
        ),
      ),
    );
  }


// Call this inside your build method
Widget _buildPromoCarousel() {
  final List<Widget> cards = [
    _buildSpecialSaleCard(),
    _buildKicksDealCard(),
    _buildLatestStylesCard(),
    _buildBanner(),
  ];

  return Column(
    children: [
      SizedBox(
        height: 150,
        child: PageView.builder(
          controller: _pageController,
          itemCount: cards.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: cards[index],
            );
          },
        ),
      ),
      const SizedBox(height: 12),
      // Dot indicators
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(cards.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _currentPage == index ? 18 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: _currentPage == index
                  ? const Color(0xFF0D47A1) // active color
                  : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    ],
  );
}


  // Private method that builds the top header row
  Widget _buildHeader() {
    // Horizontal layout
    return Row(
      // Space children apart (left and right)
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side: location info (const because static)
        const Column(
          // Align to the left
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Small “Location” label using theme style
            Text('Location', style: AppTextStyles.body),

            // Tiny vertical gap
            SizedBox(height: 2),

            // Row for the pin icon + city name
            Row(
              children: [
                // Location pin icon in primary color, size 16
                Icon(Icons.location_on, color: AppColors.primary, size: 16),

                // 4-pixel horizontal gap
                SizedBox(width: 4),

                // City name text
                Text(
                  'New York, USA', // Hard-coded location
                  style: TextStyle(
                    fontSize: 14, // Font size 14
                    fontWeight: FontWeight.w700, // Bold
                    color: AppColors.textDark, // Dark color
                  ),
                ),
              ],
            ),
          ],
        ),

        // Stack used to overlay the cart badge on the icon
        Stack(
          // Allows children to draw outside the stack bounds (needed for the badge)
          clipBehavior: Clip.none,
          children: [
            // Makes the bag icon tappable
            GestureDetector(
              // Navigate to cart screen
              onTap: () => Navigator.of(context).push(
                // Create and push CartScreen
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              // Styled container around the icon
              child: Container(
                // 10-pixel padding on all sides
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // Light gray background
                  color: const Color(0xFFF5F5FA),
                  // Rounded corners (12 px)
                  borderRadius: BorderRadius.circular(12),
                ),
                // Shopping bag outline icon
                child: const Icon(Icons.shopping_cart_outlined, color: AppColors.textDark),
              ),
            ),

            // Only show the badge if the cart has items
            if (CartModel.instance.itemCount > 0)
              // Positions the badge relative to the stack
              Positioned(
                top: -4, // 4 pixels above the top edge
                right: -4, // 4 pixels past the right edge
                // Badge container
                child: Container(
                  // Small padding
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    // Red background
                    color: Colors.redAccent,
                    // Makes it circular
                    shape: BoxShape.circle,
                  ),
                  // Minimum size so the badge is never too small
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  // The number text
                  child: Text(
                    // Converts the item count to a string
                    '${CartModel.instance.itemCount}',
                    // Center the number
                    textAlign: TextAlign.center,
                    // White, small font
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Builds the search row
  Widget _buildSearchBar() {
    // Horizontal layout
    return Row(
      children: [
        // Takes all remaining horizontal space
        Expanded(
          // Background container for the search field
          child: Container(
            // Horizontal padding 16
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              // Light gray background
              color: const Color(0xFFF5F5FA),
              // Rounded corners
              borderRadius: BorderRadius.circular(12),
            ),
            // Text input field (const because decoration is constant)
            child: const TextField(
              decoration: InputDecoration(
                // No visible border
                border: InputBorder.none,
                // Placeholder text
                hintText: 'Search products...',
                // Style of the hint
                hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14),
                // Search icon on the left
                prefixIcon: Icon(Icons.search, color: AppColors.textGrey),
              ),
            ),
          ),
        ),

        // 12-pixel gap between search and button
        const SizedBox(width: 12),

        // Makes the heart button tappable
        GestureDetector(
          // Navigate to wishlist
          onTap: () => Navigator.of(context).push(
            // Push WishlistScreen
            MaterialPageRoute(builder: (_) => const WishlistScreen()),
          ),
          // Styled button container
          child: Container(
            // 14-pixel padding
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              // Primary brand color background
              color: AppColors.primary,
              // Rounded corners
              borderRadius: BorderRadius.circular(12),
            ),
            // White outline heart icon
            child: const Icon(Icons.favorite_border, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  // Builds the promotional banner
  Widget _buildBanner() {
  return Container(
    width: double.infinity,
    height: 150, // fixed height so the image looks good
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      // Background image
      image: const DecorationImage(
        // Replace with your actual asset path if different
        image: AssetImage('assets/images/banner2.jpg'),
        fit: BoxFit.cover,
        
        // Push the person toward the right so text has space on the left
        alignment: Alignment.centerRight,
      ),
    ),
    child: Container(
      // Soft gradient on the left so the white text stays readable
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primary.withOpacity(0.85),
            AppColors.primary.withOpacity(0.4),
            Colors.transparent,
          ],
          stops: const [0.0, 0.45, 0.75],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Upper label – sits on the left, nearly touching the image
          const Text(
            'NEW COLLECTIONS',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          // Year text
          const Text(
            '2026',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Align(
  alignment: Alignment.centerLeft,
  child: ElevatedButton(
    onPressed: () {
      // handle buy now tap
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor:  const Color(0xFF4A43D9),
      elevation: 0,
      padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        //side:  const BorderSide(color: Color(0xFF4A43D9), width: 0.2),
      ),
    ),
    child:  const Text(
      'Buy Now',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10,
      ),
    ),
  ),
)
        ],
      ),
    ),
  );
}





Widget _buildSpecialSaleCard() {
  return Container(
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
      //color: const Color(0xFF0D47A1),
      borderRadius: BorderRadius.circular(20),
      image: const DecorationImage(
        // Replace with your actual asset path if different
        image: AssetImage('assets/images/bannerblue.png',),
        fit: BoxFit.cover,
        
        // Push the person toward the right so text has space on the left
        alignment: Alignment.centerRight,
      ),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 120, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enjoy up to 20%\noff in our special\nsale!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0D47A1),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Shop Now',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
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

Widget _buildKicksDealCard() {
  return Container(
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
      color: const Color(0xFFC56A4A),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 120, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Score exclusive\ndeals on your\nfavorite kicks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFC56A4A),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Grab Yours',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -6,
          bottom: 0,
          top: 8,
          child: Image.asset(
            'assets/images/banner_orange.png',
            fit: BoxFit.contain,
            width: 130,
          ),
        ),
      ],
    ),
  );
}
Widget _buildLatestStylesCard() {
  return Container(
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
      color: const Color(0xFFF5C518), // Bright yellow from the image
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 120, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'The latest styles\nare here.Shop\nbefore they\'re gone!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFF5C518),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -4,
          bottom: 0,
          top: 10,
          child: Image.asset(
            'assets/images/banner_cart.jpeg', // Use the extracted cart image
            fit: BoxFit.cover,
            width: 130,
          ),
        ),
      ],
    ),
  );
}



  // Builds the horizontal category filter list
  Widget _buildCategoryChips() {
    // Fixed height container
    return SizedBox(
      // Exactly 36 pixels tall
      height: 36,
      // Horizontal scrollable list with separators
      child: ListView.separated(
        // Scroll left-right instead of up-down
        scrollDirection: Axis.horizontal,
        // Number of chips = number of categories
        itemCount: categories.length,
        // 10-pixel gap between each chip. _ means unused parameters
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        // Builds each individual chip
        itemBuilder: (context, index) {
          // Get the category name at this index
          final category = categories[index];
          // Whether this chip is currently selected
          final isSelected = category == _selectedCategory;

          // Makes the chip tappable
          return GestureDetector(
            // Update selected category and rebuild UI
            onTap: () => setState(() => _selectedCategory = category),
            // Container that animates property changes
            child: AnimatedContainer(
              // Animation lasts 200 ms
              duration: const Duration(milliseconds: 200),
              // Horizontal padding inside the chip
              padding: const EdgeInsets.symmetric(horizontal: 18),
              // Center the text vertically and horizontally
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // Primary color if selected, light gray otherwise
                color: isSelected ? AppColors.primary : const Color(0xFFF5F5FA),
                // Rounded corners
                borderRadius: BorderRadius.circular(10),
              ),
              // The category name
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 13, // Font size 13
                  fontWeight: FontWeight.w600, // Semi-bold
                  // White if selected, gray otherwise
                  color: isSelected ? Colors.white : AppColors.textGrey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  
}