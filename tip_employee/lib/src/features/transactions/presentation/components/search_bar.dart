part of '../../transaction.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const SearchBar({
    super.key,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search transactions...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}