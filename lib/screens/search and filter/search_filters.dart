import 'package:flutter/material.dart';

/// Holds the current state of search filters.
/// Passed between SearchResultsScreen <-> FilterScreen.
class SearchFilters {
  String? category;
  String? gender;
  String? brand;
  String sortBy; // 'Popular', 'Newest', 'Price: Low to High', 'Price: High to Low'
  RangeValues priceRange;
  double minRating;

  SearchFilters({
    this.category,
    this.gender,
    this.brand,
    this.sortBy = 'Popular',
    RangeValues? priceRange,
    this.minRating = 0,
  }) : priceRange = priceRange ?? const RangeValues(0, 500);

  SearchFilters copyWith({
    String? category,
    String? gender,
    String? brand,
    String? sortBy,
    RangeValues? priceRange,
    double? minRating,
  }) {
    return SearchFilters(
      category: category ?? this.category,
      gender: gender ?? this.gender,
      brand: brand ?? this.brand,
      sortBy: sortBy ?? this.sortBy,
      priceRange: priceRange ?? this.priceRange,
      minRating: minRating ?? this.minRating,
    );
  }

  bool get isDefault =>
      category == null &&
      gender == null &&
      brand == null &&
      sortBy == 'Popular' &&
      priceRange.start == 0 &&
      priceRange.end == 500 &&
      minRating == 0;

  int get activeCount {
    int count = 0;
    if (category != null) count++;
    if (gender != null) count++;
    if (brand != null) count++;
    if (sortBy != 'Popular') count++;
    if (priceRange.start != 0 || priceRange.end != 500) count++;
    if (minRating > 0) count++;
    return count;
  }
}
