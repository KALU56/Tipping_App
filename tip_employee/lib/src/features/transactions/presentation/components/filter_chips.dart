// filter_chips.dart
part of '../../transaction.dart';

class FilterChips extends StatefulWidget {
  final List<String> filters;
  final ValueChanged<int> onFilterChanged;

  const FilterChips({super.key, required this.filters, required this.onFilterChanged});

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 8,
              right: index == widget.filters.length - 1 ? 16 : 0,
            ),
            child: FilterChip(
              label: Text(widget.filters[index]),
              selected: _selectedFilter == index,
              onSelected: (bool selected) {
                setState(() => _selectedFilter = selected ? index : 0);
                widget.onFilterChanged(_selectedFilter);
              },
              selectedColor: Colors.blue[100],
              checkmarkColor: Colors.blue,
              labelStyle: TextStyle(
                color: _selectedFilter == index ? Colors.blue : Colors.grey[700],
              ),
            ),
          );
        },
      ),
    );
  }
}
