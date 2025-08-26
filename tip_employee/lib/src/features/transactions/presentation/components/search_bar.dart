// search_bar.dart
part of '../../transaction.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  const SearchBar({super.key, required this.onSearchChanged, required Null Function(dynamic query) onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search transactions...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      onChanged: onSearchChanged,
    );
  }
}
