import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const SearchBar({
    super.key,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      decoration: InputDecoration(
        hintText: 'Search tip...',
        prefixIcon: Icon(Icons.search, color: theme.iconTheme.color?.withOpacity(0.6)),
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onSearchChanged, 
      style: theme.textTheme.bodyMedium,
    );
  }
}
