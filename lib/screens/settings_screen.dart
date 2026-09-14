import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/circle_back_button.dart';
import 'help_center_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _biometricLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.08),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _buildProfileCard(),
                      const SizedBox(height: 24),
                      _buildSectionCard(
                        title: 'Preferences',
                        children: [
                          _buildSwitchTile(
                            icon: Icons.dark_mode_outlined,
                            title: 'Dark Mode',
                            subtitle: 'Switch to a darker theme',
                            value: _darkMode,
                            onChanged: (v) => setState(() => _darkMode = v),
                          ),
                          _buildDivider(),
                          _buildSwitchTile(
                            icon: Icons.notifications_none_rounded,
                            title: 'Push Notifications',
                            subtitle: 'Alerts on your device',
                            value: _pushNotifications,
                            onChanged: (v) =>
                                setState(() => _pushNotifications = v),
                          ),
                          _buildDivider(),
                          _buildSwitchTile(
                            icon: Icons.email_outlined,
                            title: 'Email Notifications',
                            subtitle: 'Updates sent to your inbox',
                            value: _emailNotifications,
                            onChanged: (v) =>
                                setState(() => _emailNotifications = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildSectionCard(
                        title: 'Security',
                        children: [
                          _buildNavTile(
                            icon: Icons.lock_outline_rounded,
                            title: 'Change Password',
                            onTap: () {
                              // TODO: navigate to ChangePasswordScreen
                            },
                          ),
                          _buildDivider(),
                          _buildNavTile(
                            icon: Icons.shield_outlined,
                            title: 'Two-Factor Authentication',
                            onTap: () {
                              // TODO: navigate to TwoFactorAuthScreen
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchTile(
                            icon: Icons.fingerprint_rounded,
                            title: 'Biometric Login',
                            subtitle: 'Use Face ID / Fingerprint',
                            value: _biometricLogin,
                            onChanged: (v) =>
                                setState(() => _biometricLogin = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildSectionCard(
                        title: 'Support',
                        children: [
                          _buildNavTile(
                            icon: Icons.help_outline_rounded,
                            title: 'Help Center',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HelpCenterScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildNavTile(
                            icon: Icons.mail_outline_rounded,
                            title: 'Contact Us',
                            onTap: () {
                              // TODO: navigate to ContactUsScreen
                            },
                          ),
                          _buildDivider(),
                          _buildNavTile(
                            icon: Icons.privacy_tip_outlined,
                            title: 'Privacy Policy',
                            onTap: () {
                              // TODO: navigate to PrivacyPolicyScreen
                            },
                          ),
                          _buildDivider(),
                          _buildNavTile(
                            icon: Icons.description_outlined,
                            title: 'Terms of Service',
                            onTap: () {
                              // TODO: navigate to TermsOfServiceScreen
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildSectionCard(
                        children: [
                          _buildNavTile(
                            icon: Icons.logout_rounded,
                            title: 'Log Out',
                            titleColor: AppColors.error,
                            iconColor: AppColors.error,
                            onTap: () => _showLogOutSheet(context),
                          ),
                          _buildDivider(),
                          _buildNavTile(
                            icon: Icons.delete_outline_rounded,
                            title: 'Delete Account',
                            titleColor: AppColors.error,
                            iconColor: AppColors.error,
                            onTap: () => _showDeleteAccountSheet(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Row(
        children: [
          CircleBackButton(onTap: () => Navigator.pop(context)),
          const SizedBox(width: 16),
          Text('Settings', style: AppTextStyles.heading2),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.6)],
              ),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kakanyero', style: AppTextStyles.subtitle1),
                const SizedBox(height: 2),
                Text(
                  'kakanyero@example.com',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildSectionCard({String? title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body1),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColors.primary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.body1.copyWith(color: titleColor),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 52,
      endIndent: 16,
      color: AppColors.textSecondary.withOpacity(0.1),
    );
  }

  void _showLogOutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ConfirmSheet(
        title: 'Log Out',
        message: 'Are you sure you want to log out of your account?',
        confirmLabel: 'Log Out',
        onConfirm: () {
          // TODO: clear session and navigate to SignInScreen
        },
      ),
    );
  }

  void _showDeleteAccountSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ConfirmSheet(
        title: 'Delete Account',
        message:
            'This will permanently delete your account and all associated data. This action cannot be undone.',
        confirmLabel: 'Delete',
        onConfirm: () {
          // TODO: call delete account API
        },
      ),
    );
  }
}

class _ConfirmSheet extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback onConfirm;

  const _ConfirmSheet({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            alignment: Alignment.center,
          ),
          Text(title, style: AppTextStyles.heading2),
          const SizedBox(height: 10),
          Text(
            message,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text('Cancel', style: AppTextStyles.button),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    confirmLabel,
                    style: AppTextStyles.button.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
