part of '../../tip.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const SearchBar({
    super.key,
    required this.onSearchChanged,
    required Null Function(dynamic query) onChanged, // keep signature intact
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      decoration: InputDecoration(
        hintText: 'Search tip...',
        prefixIcon: Icon(Icons.search, color: theme.iconTheme.color?.withOpacity(0.6)),
        filled: true,
        fillColor: theme.cardColor, // adaptive background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onSearchChanged,
      style: theme.textTheme.bodyMedium, // adaptive text color
    );
  }
}
