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


  // ---------------- DRESSES ----------------


  Product(
    id: 'p1',
    name: 'Floral Summer Dress',
    image: 'assets/images/products/dress_1.png',
    price: 34.99,
    oldPrice: 44.99,
    category: 'Clothing',
    rating: 4.6,
    reviewCount: 58,
    description:
        'A lightweight floral dress cut for warm days, with a flattering '
        'A-line silhouette and breathable cotton-blend fabric.',
    colors: ['Red', 'Blue', 'Yellow'],
    sizes: ['S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'p2',
    name: 'Elegant Evening Dress',
    image: 'assets/images/products/dress_2.png',
    price: 59.99,
    category: 'Clothing',
    rating: 4.8,
    reviewCount: 34,
    description:
        'A tailored evening dress with a fitted bodice and flowing skirt, '
        'designed to make a statement at formal occasions.',
    colors: ['Black', 'Wine','grey'],
    sizes: ['S', 'M', 'L'],
  ),
  Product(
    id: 'p3',
    name: 'Casual Denim Dress',
    image: 'assets/images/products/dress_3.png',
    price: 29.99,
    oldPrice: 39.99,
    category: 'Clothing',
    rating: 4.2,
    reviewCount: 21,
    description:
        'A relaxed-fit denim dress with button-front styling, perfect for '
        'layering or wearing on its own with sneakers.',
    colors: ['Blue','Black', 'White'],
    sizes: ['XS', 'S', 'M', 'L'],
  ),

  Product(
    id: 'p22',
    name: 'Red T-shirt',
    image: 'assets/images/products/tshirt_red.jpg',
    price: 19.99,
    oldPrice: 39.99,
    category: 'Clothing',
    rating: 4.7,
    reviewCount: 21,
    description:
        'A gentle tshirt for use as undershirt,sports shirt and home wear '
        'layering or wearing on its own with sneakers.',
    colors: ['red'],
    sizes: ['XS', 'S', 'M', 'L'],
  ),
  Product(
    id: 'p23',
    name: 'Blue T-shirt',
    image: 'assets/images/products/tshirt_blue.jpg',
    price: 19.99,
    oldPrice: 39.99,
    category: 'Clothing',
    rating: 4.7,
    reviewCount: 21,
    description:
        'A gentle tshirt for use as undershirt,sports shirt and home wear '
        'layering or wearing on its own with sneakers.',
    colors: ['Blue'],
    sizes: ['XS', 'S', 'M', 'L'],
  ),

  
  Product(
    id: 'p4',
    name: 'Bohemian Maxi Dress',
    image: 'assets/images/products/dress_4.png',
    price: 42.99,
    category: 'Clothing',
    rating: 4.3,
    reviewCount: 71,
    description:
        'A flowing floor-length maxi dress with bohemian print detailing, '
        'ideal for beach days and summer festivals.',
  ),

  // ---------------- BACKPACK ----------------
  Product(
    id: 'p5',
    name: 'Backpack',
    image: 'assets/images/products/backpack1.png',
    price: 49.99,
    category: 'Clothing',
    rating: 4.3,
    reviewCount: 71,
    description:
        'A durable everyday backpack with padded laptop compartment, '
        'multiple pockets, and water-resistant fabric.',
  ),

  // ---------------- EARBUDS ----------------
  Product(
    id: 'p6',
    name: 'Wireless Earbuds',
    image: 'assets/images/products/earbud_1.png',
    price: 27.99,
    category: 'Electronics',
    rating: 4.1,
    reviewCount: 45,
    description:
        'True wireless earbuds with a compact charging case and up to '
        '20 hours of combined battery life.',
  ),
  Product(
    id: 'p7',
    name: 'Noise Cancelling Earbuds',
    image: 'assets/images/products/earbud_2.png',
    price: 39.99,
    oldPrice: 49.99,
    category: 'Electronics',
    rating: 4.6,
    reviewCount: 88,
    description:
        'Active noise cancelling earbuds that block out background noise '
        'for immersive sound, with a secure in-ear fit.',
  ),
  Product(
    id: 'p8',
    name: 'Sport Wireless Earbuds',
    image: 'assets/images/products/earbud_3.png',
    price: 24.99,
    category: 'Electronics',
    rating: 4.0,
    reviewCount: 19,
    description:
        'Sweat-resistant wireless earbuds built for workouts, with secure '
        'ear hooks that stay put during movement.',
  ),

  // ---------------- HEADPHONES ----------------
  Product(
    id: 'p9',
    name: 'Over-Ear Headphones',
    image: 'assets/images/products/headphone_2.png',
    price: 59.99,
    oldPrice: 79.99,
    category: 'Electronics',
    rating: 4.7,
    reviewCount: 102,
    description:
        'Over-ear headphones with plush cushioned earcups and deep bass, '
        'built for long listening sessions.',
  ),
  Product(
    id: 'p10',
    name: 'Studio Headphones',
    image: 'assets/images/products/headphone_3.png',
    price: 89.99,
    category: 'Electronics',
    rating: 4.9,
    reviewCount: 63,
    description:
        'Studio-grade headphones with accurate, balanced sound reproduction, '
        'favored by producers and audio engineers.',
  ),
  Product(
    id: 'p11',
    name: 'Bluetooth Headphones',
    image: 'assets/images/products/headphone_4.png',
    price: 44.99,
    category: 'Electronics',
    rating: 4.2,
    reviewCount: 27,
    description:
        'Foldable Bluetooth headphones with a lightweight design, great for '
        'commuting and everyday listening.',
  ),

  // ---------------- LIPSTICK ----------------
  Product(
    id: 'p12',
    name: 'Matte Lipstick',
    image: 'assets/images/products/lipstick_1.png',
    price: 12.99,
    category: 'Beauty',
    rating: 4.4,
    reviewCount: 95,
    description:
        'A long-wearing matte lipstick with full-coverage pigment and a '
        'smooth, non-drying formula.',
    colors: ['Red', 'Pink', 'Nude'],
  ),
  Product(
    id: 'p13',
    name: 'Glossy Lipstick',
    image: 'assets/images/products/lipstick_2.png',
    price: 9.99,
    oldPrice: 14.99,
    category: 'Beauty',
    rating: 4.3,
    reviewCount: 52,
    description:
        'A high-shine glossy lipstick that hydrates lips while delivering '
        'a vibrant pop of color.',
    colors: ['Coral', 'Berry'],
  ),

  // ---------------- PHONES ----------------
  Product(
    id: 'p14',
    name: 'Smartphone X1',
    image: 'assets/images/products/phone_1.png',
    price: 499.99,
    oldPrice: 599.99,
    category: 'Electronics',
    rating: 4.5,
    reviewCount: 214,
    description:
        'A mid-range smartphone with a 6.5" display, triple camera setup, '
        'and all-day battery life.',
    colors: ['Black', 'Silver', 'Gold'],
  ),
  Product(
    id: 'p15',
    name: 'Smartphone Lite',
    image: 'assets/images/products/phone_2.png',
    price: 299.99,
    category: 'Electronics',
    rating: 4.1,
    reviewCount: 87,
    description:
        'An affordable smartphone with reliable everyday performance and '
        'a compact, easy-to-hold design.',
    colors: ['Black', 'Blue'],
  ),
  Product(
    id: 'p16',
    name: 'Smartphone Pro Max',
    image: 'assets/images/products/phone_3.png',
    price: 799.99,
    oldPrice: 899.99,
    category: 'Electronics',
    rating: 4.8,
    reviewCount: 341,
    description:
        'A flagship smartphone with a pro-grade camera system, fast '
        'charging, and a stunning edge-to-edge display.',
    colors: ['Black', 'Titanium'],
  ),

  // ---------------- SNEAKERS ----------------
  Product(
    id: 'p17',
    name: 'Classic Sneakers',
    image: 'assets/images/products/sneakers_6.png',
    price: 54.99,
    oldPrice: 69.99,
    category: 'Clothing',
    rating: 4.5,
    reviewCount: 130,
    description:
        'Everyday sneakers with a cushioned sole and breathable mesh upper, '
        'built for comfort from morning to night.',
    colors: ['White', 'Black', 'Grey'],
    sizes: ['38', '39', '40', '41', '42', '43'],
  ),

  // ---------------- TROUSERS ----------------
  Product(
    id: 'p18',
    name: 'Slim Fit Trousers',
    image: 'assets/images/products/trouser_3.png',
    price: 32.99,
    category: 'Clothing',
    rating: 4.2,
    reviewCount: 44,
    description:
        'Slim-fit tailored trousers made from a stretch fabric blend for a '
        'sharp look with all-day comfort.',
    colors: ['Black', 'Navy', 'Khaki'],
    sizes: ['S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'p19',
    name: 'Casual Chino Trousers',
    image: 'assets/images/products/trouser.png',
    price: 27.99,
    oldPrice: 34.99,
    category: 'Clothing',
    rating: 4.0,
    reviewCount: 26,
    description:
        'Relaxed chino trousers with a soft cotton finish, versatile enough '
        'for both work and weekend wear.',
    colors: ['Beige', 'Grey'],
    sizes: ['S', 'M', 'L'],
  ),

  // ---------------- WATCHES ----------------
  Product(
    id: 'p20',
    name: 'Classic Analog Watch',
    image: 'assets/images/products/watch_1.png',
    price: 79.99,
    oldPrice: 99.99,
    category: 'Electronics',
    rating: 4.6,
    reviewCount: 76,
    description:
        'A timeless analog watch with a stainless steel case and genuine '
        'leather strap, water-resistant up to 30 meters.',
    colors: ['Brown', 'Black'],
  ),
  Product(
    id: 'p21',
    name: 'Smartwatch Series 3',
    image: 'assets/images/products/watch_3.png',
    price: 129.99,
    category: 'Electronics',
    rating: 4.7,
    reviewCount: 159,
    description:
        'A feature-packed smartwatch with heart-rate tracking, GPS, and '
        'up to 5 days of battery life.',
    colors: ['Black', 'Silver'],
  ),
  Product(
    id: 'p22',
    name: 'Minimalist Watch',
    image: 'assets/images/products/watch_4.png',
    price: 64.99,
    oldPrice: 79.99,
    category: 'Electronics',
    rating: 4.4,
    reviewCount: 38,
    description:
        'A slim, minimalist watch with a clean dial face and adjustable '
        'mesh band, suited to any outfit.',
    colors: ['Gold', 'Silver'],
  ),
    // ---------------- NEW: NETWORK IMAGE PRODUCTS ----------------
  Product(
    id: 'p23',
    name: 'Denim Jacket',
    image: 'https://loremflickr.com/400/400/denim-jacket',
    price: 54.99,
    oldPrice: 69.99,
    category: 'Clothing',
    rating: 4.4,
    reviewCount: 63,
    description:
        'A classic denim jacket with a relaxed fit, button-front closure, '
        'and two chest pockets — a year-round wardrobe staple.',
    colors: ['Blue', 'Black'],
    sizes: ['S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'p24',
    name: 'Aviator Sunglasses',
    image: 'https://loremflickr.com/400/400/sunglasses',
    price: 19.99,
    category: 'Beauty',
    rating: 4.3,
    reviewCount: 87,
    description:
        'Classic aviator-style sunglasses with UV400 protection and a '
        'lightweight metal frame.',
    colors: ['Gold', 'Silver', 'Black'],
  ),
  Product(
    id: 'p25',
    name: 'Leather Wallet',
    image: 'https://loremflickr.com/400/400/leather-wallet',
    price: 24.99,
    oldPrice: 32.99,
    category: 'Clothing',
    rating: 4.6,
    reviewCount: 112,
    description:
        'A slim genuine-leather bifold wallet with multiple card slots '
        'and a coin pocket.',
    colors: ['Brown', 'Black'],
  ),
  Product(
    id: 'p26',
    name: 'Compact Camera',
    image: 'https://loremflickr.com/400/400/camera',
    price: 219.99,
    category: 'Electronics',
    rating: 4.5,
    reviewCount: 39,
    description:
        'A compact digital camera with a 20MP sensor and 4x optical zoom, '
        'great for everyday photography.',
  ),
  Product(
    id: 'p27',
    name: 'Ultrabook Laptop',
    image: 'https://loremflickr.com/400/400/laptop',
    price: 899.99,
    oldPrice: 999.99,
    category: 'Electronics',
    rating: 4.7,
    reviewCount: 204,
    description:
        'A thin and light laptop with a 14" display, all-day battery life, '
        'and fast SSD storage.',
    colors: ['Silver', 'Space Grey'],
  ),
  Product(
    id: 'p28',
    name: 'Countertop Blender',
    image: 'https://loremflickr.com/400/400/blender',
    price: 44.99,
    category: 'Electronics',
    rating: 4.2,
    reviewCount: 56,
    description:
        'A powerful countertop blender with multiple speed settings, '
        'perfect for smoothies and soups.',
  ),
  Product(
    id: 'p29',
    name: 'Canvas Tote Bag',
    image: 'https://loremflickr.com/400/400/tote-bag',
    price: 17.99,
    category: 'Clothing',
    rating: 4.1,
    reviewCount: 29,
    description:
        'A durable canvas tote bag with reinforced handles, roomy enough '
        'for daily essentials or groceries.',
    colors: ['Beige', 'Navy'],
  ),
  Product(
    id: 'p30',
    name: 'Gold Hoop Earrings',
    image: 'https://loremflickr.com/400/400/hoop-earrings',
    price: 14.99,
    oldPrice: 19.99,
    category: 'Beauty',
    rating: 4.5,
    reviewCount: 74,
    description:
        'Lightweight gold-plated hoop earrings that add a polished '
        'finishing touch to any outfit.',
  ),
  Product(
    id: 'p31',
    name: 'Eau de Parfum',
    image: 'https://picsum.photos/seed/perfume/400/400',
    price: 39.99,
    category: 'Beauty',
    rating: 4.6,
    reviewCount: 98,
    description:
        'A long-lasting eau de parfum with warm floral and woody notes, '
        'presented in an elegant glass bottle.',
  ),
  Product(
    id: 'p32',
    name: 'Running Shoes',
    image: 'https://loremflickr.com/400/400/running-shoes',
    price: 64.99,
    oldPrice: 79.99,
    category: 'Shoes',
    rating: 4.7,
    reviewCount: 156,
    description:
        'Lightweight running shoes with responsive cushioning and a '
        'breathable knit upper.',
    colors: ['Black', 'White', 'Red'],
    sizes: ['38', '39', '40', '41', '42', '43'],
  ),
  Product(
    id: 'p33',
    name: 'Ankle Boots',
    image: 'https://loremflickr.com/400/400/ankle-boots',
    price: 74.99,
    category: 'Shoes',
    rating: 4.4,
    reviewCount: 42,
    description:
        'Sleek leather-look ankle boots with a low block heel, easy to '
        'dress up or down.',
    colors: ['Black', 'Tan'],
    sizes: ['36', '37', '38', '39', '40'],
  ),
  Product(
    id: 'p34',
    name: 'Wireless Charging Pad',
    image: 'https://loremflickr.com/400/400/wireless-charger',
    price: 22.99,
    oldPrice: 27.99,
    category: 'Electronics',
    rating: 4.3,
    reviewCount: 67,
    description:
        'A fast wireless charging pad compatible with most Qi-enabled '
        'phones and earbud cases.',
  ),
];

