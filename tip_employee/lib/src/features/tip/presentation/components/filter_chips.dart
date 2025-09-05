import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onFilterChanged;

  const FilterChips({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(filters[index]),
              selected: isSelected,
              onSelected: (_) => onFilterChanged(index),
              selectedColor: theme.colorScheme.primary,
              backgroundColor: theme.cardColor,
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? theme.colorScheme.onPrimary : theme.textTheme.bodyMedium?.color,
              ),
            ),
          );
        },
      ),
    );
  }
}
