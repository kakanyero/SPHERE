
enum OrderStatus { ongoing, completed, cancelled }

class OrderItem {
  final String name;
  final String imagePath; // network URL or local asset path
  final double price;
  final int quantity;

  const OrderItem({
    required this.name,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });
}

/// One step in the tracking timeline (e.g. "Order Confirmed", "Shipped").
class TrackingStep {
  final String title;
  final String? subtitle; // e.g. a timestamp or courier note
  final bool isComplete;

  const TrackingStep({
    required this.title,
    this.subtitle,
    required this.isComplete,
  });
}

class Order {
  final String id;
  final DateTime date;
  final OrderStatus status;
  final List<OrderItem> items;
  final List<TrackingStep> trackingSteps;
  final String shippingAddress;
  final String paymentMethod;

  const Order({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    this.trackingSteps = const [],
    this.shippingAddress = '',
    this.paymentMethod = '',
  });

  double get total =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}

/// TODO: replace with your real order source (API call or a proper
/// ChangeNotifier-backed OrdersModel, mirroring your CartModel pattern).
/// This is sample data so MyOrdersScreen and OrderTrackingScreen compile
/// and render standalone.
class OrdersRepository {
  OrdersRepository._();
  static final OrdersRepository instance = OrdersRepository._();

  final List<Order> _orders = [
    Order(
      id: '#04Y5327652',
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: OrderStatus.ongoing,
      shippingAddress: '221B Baker Street, Kampala',
      paymentMethod: 'Cash On Delivery',
      items: const [
        OrderItem(
          name: 'Black T-Shirt',
          imagePath: 'https://loremflickr.com/300/300/tshirt',
          price: 29.99,
        ),
        OrderItem(
          name: 'Logitech Headphone',
          imagePath: 'https://loremflickr.com/300/300/headphone',
          price: 89.99,
        ),
      ],
      trackingSteps: [
        TrackingStep(title: 'Order Confirmed', subtitle: 'Yesterday, 10:20 AM', isComplete: true),
        TrackingStep(title: 'Order Processed', subtitle: 'Yesterday, 2:40 PM', isComplete: true),
        const TrackingStep(title: 'Shipped', subtitle: null, isComplete: false),
        const TrackingStep(title: 'Out For Delivery', subtitle: null, isComplete: false),
        const TrackingStep(title: 'Delivered', subtitle: null, isComplete: false),
      ],
    ),
    Order(
      id: '#04Y5327410',
      date: DateTime.now().subtract(const Duration(days: 12)),
      status: OrderStatus.completed,
      shippingAddress: '221B Baker Street, Kampala',
      paymentMethod: 'Card',
      items: const [
        OrderItem(
          name: 'White Sneakers',
          imagePath: 'https://loremflickr.com/300/300/sneakers',
          price: 59.99,
        ),
      ],
    ),
    Order(
      id: '#04Y5326810',
      date: DateTime.now().subtract(const Duration(days: 30)),
      status: OrderStatus.cancelled,
      shippingAddress: '221B Baker Street, Kampala',
      paymentMethod: 'Cash On Delivery',
      items: const [
        OrderItem(
          name: 'Backpack',
          imagePath: 'https://loremflickr.com/300/300/backpack',
          price: 45.00,
        ),
      ],
    ),
  ];

  List<Order> get all => List.unmodifiable(_orders);

  List<Order> byStatus(OrderStatus status) =>
      _orders.where((o) => o.status == status).toList();
}
