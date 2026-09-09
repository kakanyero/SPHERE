import 'package:flutter/material.dart';
import 'search_results_screen.dart';
import 'search_filters.dart';

/// Entry point for search: search bar + recent searches + live suggestions.
/// Matches the mockup's keyboard-open state with "Similar matches" list.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // TODO: replace with persisted recent searches (e.g. shared_preferences).
  final List<String> _recentSearches = [
    'Headphone',
    'Black T-Shirt',
    'Sneakers',
  ];

  // TODO: replace with a real lookup against product_data.dart (name/category/brand match).
  List<String> _suggestionsFor(String query) {
    if (query.isEmpty) return [];
    const allTerms = [
      'Headphone',
      'Headphone Wireless',
      'Black T-Shirt',
      'White T-Shirt',
      'Sneakers',
      'Running Shoes',
      'Smart Watch',
      'Backpack',
    ];
    return allTerms
        .where((t) => t.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _submitSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    setState(() {
      _recentSearches.remove(trimmed);
      _recentSearches.insert(0, trimmed);
      if (_recentSearches.length > 8) _recentSearches.removeLast();
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(
          query: trimmed,
          initialFilters: SearchFilters(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = _suggestionsFor(_controller.text);
    final showingSuggestions = _controller.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: _SearchField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (_) => setState(() {}),
          onSubmitted: _submitSearch,
        ),
        titleSpacing: 0,
      ),
      body: showingSuggestions
          ? _SuggestionsList(
              suggestions: suggestions,
              onTap: _submitSearch,
            )
          : _RecentSearchesView(
              recentSearches: _recentSearches,
              onTap: _submitSearch,
              onClearAll: () => setState(() => _recentSearches.clear()),
              onRemove: (term) => setState(() => _recentSearches.remove(term)),
            ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  const _SearchField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

class _RecentSearchesView extends StatelessWidget {
  final List<String> recentSearches;
  final ValueChanged<String> onTap;
  final VoidCallback onClearAll;
  final ValueChanged<String> onRemove;

  const _RecentSearchesView({
    required this.recentSearches,
    required this.onTap,
    required this.onClearAll,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) {
      return const Center(
        child: Text(
          'No recent searches',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Searches',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: onClearAll,
              child: const Text('Clear All'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ...recentSearches.map(
          (term) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.history, color: Colors.grey),
            title: Text(term),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 18, color: Colors.grey),
              onPressed: () => onRemove(term),
            ),
            onTap: () => onTap(term),
          ),
        ),
      ],
    );
  }
}

class _SuggestionsList extends StatelessWidget {
  final List<String> suggestions;
  final ValueChanged<String> onTap;

  const _SuggestionsList({required this.suggestions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return const Center(
        child: Text(
          'No matches found',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        const Text(
          'Similar Matches',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...suggestions.map(
          (term) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.search, color: Colors.grey),
            title: Text(term),
            trailing: const Icon(Icons.north_west, size: 16, color: Colors.grey),
            onTap: () => onTap(term),
          ),
        ),
      ],
    );
  }
}
