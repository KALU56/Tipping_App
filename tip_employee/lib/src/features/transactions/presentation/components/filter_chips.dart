part of '../../transaction.dart';

class FilterChips extends StatefulWidget {
  final List<String> filters;
  final ValueChanged<int> onFilterChanged;

  const FilterChips({
    super.key,
    required this.filters,
    required this.onFilterChanged,
  });

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        itemBuilder: (context, index) {
          final bool isSelected = _selectedFilter == index;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(
                widget.filters[index],
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() => _selectedFilter = selected ? index : 0);
                widget.onFilterChanged(_selectedFilter);
              },
              selectedColor: theme.colorScheme.primary,
              backgroundColor: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}
