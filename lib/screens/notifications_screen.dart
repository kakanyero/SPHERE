import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum NotificationType { order, promo, system }

class AppNotification {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final DateTime timestamp;
  bool isRead;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  factory AppNotification.fromRow(Map<String, dynamic> r) => AppNotification(
        id: r['id'] as String,
        type: NotificationType.values.byName(r['type'] as String),
        title: r['title'] as String,
        message: r['message'] as String,
        timestamp: DateTime.parse(r['created_at'] as String).toLocal(),
        isRead: r['is_read'] as bool,
      );
}

/// Supabase-backed notifications.
class NotificationsRepository extends ChangeNotifier {
  NotificationsRepository._();
  static final NotificationsRepository instance = NotificationsRepository._();

  final List<AppNotification> _notifications = [];

  SupabaseClient get _db => Supabase.instance.client;
  String? get _uid => _db.auth.currentUser?.id;

  List<AppNotification> get all => List.unmodifiable(_notifications);
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> load() async {
    final uid = _uid;
    if (uid == null) return;
    try {
      final rows = await _db
          .from('notifications')
          .select()
          .eq('user_id', uid)
          .order('created_at', ascending: false);
      _notifications
        ..clear()
        ..addAll(rows.map<AppNotification>(AppNotification.fromRow));
      notifyListeners();
    } catch (e) {
      debugPrint('Notifications load failed: $e');
    }
  }

  void resetLocal() {
    _notifications.clear();
    notifyListeners();
  }

  void markAsRead(String id) {
    final n = _notifications.firstWhere((n) => n.id == id);
    if (n.isRead) return;
    n.isRead = true;
    notifyListeners();
    _db.from('notifications').update({'is_read': true}).eq('id', id).then((_) {}).catchError((e) {
      debugPrint('markAsRead failed: $e');
    });
  }

  void markAllAsRead() {
    for (final n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
    final uid = _uid;
    if (uid != null) {
      _db
          .from('notifications')
          .update({'is_read': true})
          .eq('user_id', uid)
          .eq('is_read', false)
          .then((_) {})
          .catchError((e) {
        debugPrint('markAllAsRead failed: $e');
      });
    }
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    NotificationsRepository.instance.addListener(_refresh);
    NotificationsRepository.instance.load(); // refresh on open
  }

  @override
  void dispose() {
    NotificationsRepository.instance.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Map<String, List<AppNotification>> _groupByDay(List<AppNotification> items) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final grouped = <String, List<AppNotification>>{};
    for (final n in items) {
      final date = DateTime(n.timestamp.year, n.timestamp.month, n.timestamp.day);
      final key = date == today
          ? 'Today'
          : date == yesterday
              ? 'Yesterday'
              : 'Earlier';
      grouped.putIfAbsent(key, () => []).add(n);
    }
    return grouped;
  }

  IconData _iconFor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.local_shipping_outlined;
      case NotificationType.promo:
        return Icons.local_offer_outlined;
      case NotificationType.system:
        return Icons.info_outline;
    }
  }

  String _timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final notifications = NotificationsRepository.instance.all;
    final grouped = _groupByDay(notifications);
    final primary = Theme.of(context).primaryColor;
    const order = ['Today', 'Yesterday', 'Earlier'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Notifications', style: TextStyle(color: Colors.black87)),
        actions: [
          TextButton(
            onPressed: NotificationsRepository.instance.markAllAsRead,
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text('No notifications yet', style: TextStyle(color: Colors.grey.shade500)),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                for (final section in order)
                  if (grouped[section]?.isNotEmpty ?? false) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        section,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...grouped[section]!.map(
                      (n) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => NotificationsRepository.instance.markAsRead(n.id),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: n.isRead ? const Color(0xFFF5F5F7) : primary.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: primary.withOpacity(0.12),
                                  child: Icon(_iconFor(n.type), color: primary, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              n.title,
                                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          if (!n.isRead)
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        n.message,
                                        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        _timeAgo(n.timestamp),
                                        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
              ],
            ),
    );
  }
}