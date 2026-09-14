import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/circle_back_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _FaqItem {
  final String question;
  final String answer;
  final String category;
  bool expanded;

  _FaqItem({
    required this.question,
    required this.answer,
    required this.category,
    this.expanded = false,
  });
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _query = '';

  final List<String> _categories = [
    'All',
    'Account',
    'Security',
    'Payments',
    'Orders',
  ];

  final List<_FaqItem> _faqs = [
    _FaqItem(
      category: 'Account',
      question: 'How do I update my profile information?',
      answer:
          'Go to Settings > Profile, tap the edit icon next to your name, make your changes, and tap Save.',
    ),
    _FaqItem(
      category: 'Account',
      question: 'How do I delete my account?',
      answer:
          'Open Settings, scroll to the bottom, and tap Delete Account. This action is permanent and cannot be undone.',
    ),
    _FaqItem(
      category: 'Security',
      question: 'How do I reset my password?',
      answer:
          'On the sign-in screen, tap "Forgot Password", enter your email, and follow the reset link we send you.',
    ),
    _FaqItem(
      category: 'Security',
      question: 'How do I enable two-factor authentication?',
      answer:
          'Go to Settings > Security > Two-Factor Authentication and follow the setup steps to link your device.',
    ),
    _FaqItem(
      category: 'Payments',
      question: 'What payment methods are supported?',
      answer:
          'We support major debit and credit cards, along with mobile money where available in your region.',
    ),
    _FaqItem(
      category: 'Orders',
      question: 'How do I track my order?',
      answer:
          'Open the Orders tab and select an order to view its live tracking status and estimated delivery date.',
    ),
    _FaqItem(
      category: 'Orders',
      question: 'Can I cancel an order after placing it?',
      answer:
          'Orders can be cancelled within 30 minutes of placement from the Order Details screen, before it ships.',
    ),
  ];

  List<_FaqItem> get _filteredFaqs {
    return _faqs.where((f) {
      final matchesCategory =
          _selectedCategory == 'All' || f.category == _selectedCategory;
      final matchesQuery = _query.isEmpty ||
          f.question.toLowerCase().contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: CustomTextField(
                  controller: _searchController,
                  hintText: 'Search for help...',
                  prefixIcon: Icons.search_rounded,
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
              const SizedBox(height: 16),
              _buildCategoryChips(),
              const SizedBox(height: 8),
              Expanded(
                child: _filteredFaqs.isEmpty
                    ? _buildEmptyState()
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                        children: [
                          ..._filteredFaqs.map(_buildFaqCard),
                          const SizedBox(height: 12),
                          _buildContactCard(context),
                          const SizedBox(height: 24),
                        ],
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
          Text('Help Center', style: AppTextStyles.heading2),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary.withOpacity(0.15),
                ),
              ),
              child: Center(
                child: Text(
                  category,
                  style: AppTextStyles.body2.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFaqCard(_FaqItem faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => faq.expanded = !faq.expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      faq.question,
                      style: AppTextStyles.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: faq.expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 180),
            crossFadeState: faq.expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  faq.answer,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Still need help?',
            style: AppTextStyles.subtitle1.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            'Our support team usually replies within a few hours.',
            style: AppTextStyles.body2.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Contact Support',
                  onPressed: () {
                    // TODO: navigate to ContactSupportScreen or open chat
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'No results found',
            style: AppTextStyles.body1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try a different search term or category',
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
