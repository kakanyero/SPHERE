import 'package:flutter/material.dart';
import 'search_filters.dart';

/// Full-screen filter panel matching the mockup: Category, Gender, Sort By,
/// Brand, Price Range slider, and Rating. Returns the updated SearchFilters
/// via Navigator.pop when the user taps Apply.
class FilterScreen extends StatefulWidget {
  final SearchFilters initialFilters;

  const FilterScreen({super.key, required this.initialFilters});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late SearchFilters _filters;

  // TODO: replace with real category/brand lists sourced from product_data.dart.
  final List<String> _categories = ['Clothing', 'Headphone', 'Shoes', 'Watch'];
  final List<String> _genders = ['Male', 'Female', 'Unisex'];
  final List<String> _sortOptions = [
    'Popular',
    'Newest',
    'Price: Low to High',
    'Price: High to Low',
  ];
  final List<String> _brands = ['Logitech', 'Nike', 'Adidas', 'Apple'];

  @override
  void initState() {
    super.initState();
    // Copy so cancelling this screen doesn't mutate the caller's filters.
    _filters = widget.initialFilters.copyWith();
  }

  void _reset() {
    setState(() => _filters = SearchFilters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Filter', style: TextStyle(color: Colors.black87)),
        actions: [
          TextButton(
            onPressed: _reset,
            child: const Text('Reset'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          _SectionTitle('Category'),
          _ChipGroup(
            options: _categories,
            selected: _filters.category,
            onSelected: (v) => setState(() => _filters.category = v),
          ),
          const SizedBox(height: 20),
          _SectionTitle('Gender'),
          _ChipGroup(
            options: _genders,
            selected: _filters.gender,
            onSelected: (v) => setState(() => _filters.gender = v),
          ),
          const SizedBox(height: 20),
          _SectionTitle('Sort By'),
          _ChipGroup(
            options: _sortOptions,
            selected: _filters.sortBy,
            onSelected: (v) => setState(() => _filters.sortBy = v ?? 'Popular'),
            allowDeselect: false,
          ),
          const SizedBox(height: 20),
          _SectionTitle('Available Brand'),
          _ChipGroup(
            options: _brands,
            selected: _filters.brand,
            onSelected: (v) => setState(() => _filters.brand = v),
          ),
          const SizedBox(height: 20),
          _SectionTitle('Price Range'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${_filters.priceRange.start.round()}'),
              Text('\$${_filters.priceRange.end.round()}'),
            ],
          ),
          RangeSlider(
            values: _filters.priceRange,
            min: 0,
            max: 500,
            divisions: 50,
            activeColor: Theme.of(context).primaryColor,
            labels: RangeLabels(
              '\$${_filters.priceRange.start.round()}',
              '\$${_filters.priceRange.end.round()}',
            ),
            onChanged: (range) => setState(() => _filters.priceRange = range),
          ),
          const SizedBox(height: 12),
          _SectionTitle('Reviews'),
          Row(
            children: List.generate(5, (i) {
              final starValue = i + 1;
              final filled = starValue <= _filters.minRating;
              return IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  filled ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () => setState(() {
                  // Tapping the currently-selected star clears the filter.
                  _filters.minRating =
                      _filters.minRating == starValue.toDouble() ? 0 : starValue.toDouble();
                }),
              );
            }),
          ),
          const SizedBox(height: 90),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(_filters),
              child: const Text(
                'Apply Filter',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// Single-select chip group. Pass allowDeselect:false for options
/// that always need exactly one value selected (e.g. Sort By).
class _ChipGroup extends StatelessWidget {
  final List<String> options;
  final String? selected;
  final ValueChanged<String?> onSelected;
  final bool allowDeselect;

  const _ChipGroup({
    required this.options,
    required this.selected,
    required this.onSelected,
    this.allowDeselect = true,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = option == selected;
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (_) {
            if (isSelected && allowDeselect) {
              onSelected(null);
            } else {
              onSelected(option);
            }
          },
          selectedColor: Theme.of(context).primaryColor,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 13,
          ),
          backgroundColor: const Color(0xFFF5F5F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide.none,
          ),
        );
      }).toList(),
    );
  }
}
