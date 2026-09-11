import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// TODO: add to pubspec.yaml -> share_plus: ^7.x (or latest)
import 'package:share_plus/share_plus.dart';

/// Referral code display + copy + native share sheet.
class InviteFriendScreen extends StatelessWidget {
  // TODO: replace with the real referral code from the user's account/API.
  final String referralCode;

  const InviteFriendScreen({super.key, this.referralCode = 'Sphere-JD284'});

  String get _shareMessage =>
      'Join me on Sphere! Use my code $referralCode to get a discount on your first order. '
      'Download the app: https://Sphere.app/invite/$referralCode';

  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied')),
    );
  }

  void _shareCode() {
    Share.share(_shareMessage);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Invite Friend', style: TextStyle(color: Colors.black87)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(Icons.card_giftcard, size: 80, color: primary),
            const SizedBox(height: 20),
            const Text(
              'Invite Friends & Earn Rewards',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Share your referral code with friends. When they sign up '
              'and place their first order, you both get a discount.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primary.withOpacity(0.3), style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Referral Code',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        referralCode,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _copyCode(context),
                        child: Icon(Icons.copy, size: 18, color: primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _shareCode,
                icon: const Icon(Icons.share, color: Colors.white, size: 18),
                label: const Text('Share Invite Link', style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _copyCode(context),
                child: Text('Copy Code', style: TextStyle(fontSize: 15, color: primary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
