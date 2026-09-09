import 'package:flutter/material.dart';
import 'package:sphere/models/user_model.dart';
import 'edit_profile_screen.dart';
import 'package:sphere/screens/orders/my_orders_screen.dart';
import 'package:sphere/screens/notifications_screen.dart';
import 'package:sphere/screens/shipping_address_screen.dart';
import 'package:sphere/screens/invite_friend_screen.dart';

// TODO: replace with your actual screen imports once built, e.g.:
// import 'wishlist_screen.dart';
// import 'payment_method_screen.dart';
// import 'change_password_screen.dart';
// import 'sign_in_screen.dart';

/// Profile screen: avatar/name header + "My Account" menu list.
/// Matches the mockup's profile screen with Payment Method, Shipping
/// Address, Notification, Change Password, Log Out list items.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _editProfile() async {
    final updated = await Navigator.of(context).push<UserProfile>(
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(profile: UserRepository.instance.current),
      ),
    );
    if (updated != null) setState(() {}); // refresh header with new info
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // TODO: clear auth/session state, then navigate to SignInScreen
              // and remove all previous routes, e.g.:
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (_) => const SignInScreen()),
              //   (route) => false,
              // );
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = UserRepository.instance.current;
    final primary = Theme.of(context).primaryColor;
    final hasAvatar = user.avatarImagePath != null && user.avatarImagePath!.isNotEmpty;
    final isNetworkAvatar = hasAvatar && user.avatarImagePath!.startsWith('http');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // this is a bottom-nav tab root
        title: const Text('Profile', style: TextStyle(color: Colors.black87)),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined, color: primary),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: primary.withOpacity(0.1),
                  backgroundImage: hasAvatar
                      ? (isNetworkAvatar
                          ? NetworkImage(user.avatarImagePath!)
                          : AssetImage(user.avatarImagePath!)) as ImageProvider
                      : null,
                  child: !hasAvatar ? Icon(Icons.person, size: 44, color: primary) : null,
                ),
                const SizedBox(height: 12),
                Text(user.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(user.email, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const _SectionLabel('My Account'),
          _ProfileMenuItem(
            icon: Icons.shopping_bag_outlined,
            label: 'My Orders',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
            ),
          ),
          _ProfileMenuItem(
            icon: Icons.favorite_border,
            label: 'Wishlist',
            onTap: () {
              // TODO: Navigator.push to WishlistScreen (already exists).
            },
          ),
          _ProfileMenuItem(
            icon: Icons.credit_card_outlined,
            label: 'Payment Method',
            onTap: () {
              // TODO: Navigator.push to PaymentMethodScreen once built.
            },
          ),
          _ProfileMenuItem(
            icon: Icons.location_on_outlined,
            label: 'Shipping Address',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ShippingAddressScreen()),
            ),
          ),
          _ProfileMenuItem(
            icon: Icons.notifications_none,
            label: 'Notifications',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
          ),
          _ProfileMenuItem(
            icon: Icons.person_add_alt_outlined,
            label: 'Invite Friend',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const InviteFriendScreen()),
            ),
          ),
          const SizedBox(height: 20),
          const _SectionLabel('Settings'),
          _ProfileMenuItem(
            icon: Icons.lock_outline,
            label: 'Change Password',
            onTap: () {
              // TODO: Navigator.push to ChangePasswordScreen once built.
            },
          ),
          _ProfileMenuItem(
            icon: Icons.help_outline,
            label: 'Help Center',
            onTap: () {
              // TODO: Navigator.push to a HelpCenterScreen once built.
            },
          ),
          _ProfileMenuItem(
            icon: Icons.logout,
            label: 'Log Out',
            iconColor: Colors.redAccent,
            labelColor: Colors.redAccent,
            onTap: () => _confirmLogout(context),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.black87, size: 22),
        title: Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: labelColor ?? Colors.black87),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
