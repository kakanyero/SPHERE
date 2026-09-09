import 'package:flutter/material.dart';
import 'package:sphere/models/order_model.dart';

/// Vertical stepper-style tracking view for a single order.
/// Matches the mockup's "Order #04Y5327652" tracking screen.
class OrderTrackingScreen extends StatelessWidget {
  final Order order;

  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          'Order ${order.id}',
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _ProductStrip(items: order.items),
          const SizedBox(height: 24),
          const Text(
            'Tracking Status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _TrackingTimeline(steps: order.trackingSteps),
          const SizedBox(height: 24),
          _InfoCard(
            title: 'Shipping Address',
            value: order.shippingAddress,
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Payment Method',
            value: order.paymentMethod,
            icon: Icons.payment_outlined,
          ),
        ],
      ),
    );
  }
}

class _ProductStrip extends StatelessWidget {
  final List<OrderItem> items;
  const _ProductStrip({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.map((item) {
          final isNetwork = item.imagePath.startsWith('http');
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: isNetwork
                        ? Image.network(item.imagePath, fit: BoxFit.cover)
                        : Image.asset(item.imagePath, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.name,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'x${item.quantity}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TrackingTimeline extends StatelessWidget {
  final List<TrackingStep> steps;
  const _TrackingTimeline({required this.steps});

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return Text(
        'No tracking information available yet.',
        style: TextStyle(color: Colors.grey.shade600),
      );
    }

    final primary = Theme.of(context).primaryColor;

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: step.isComplete ? primary : Colors.grey.shade300,
                    ),
                    child: step.isComplete
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: step.isComplete ? primary : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: step.isComplete ? Colors.black87 : Colors.grey.shade500,
                        ),
                      ),
                      if (step.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          step.subtitle!,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
