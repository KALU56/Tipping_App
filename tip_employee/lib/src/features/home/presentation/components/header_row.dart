part of '../../home.dart';

class _HeaderRow extends StatefulWidget {
  final String userName;

  const _HeaderRow({this.userName = "Kali", Key? key}) : super(key: key);

  @override
  State<_HeaderRow> createState() => _HeaderRowState();
}

class _HeaderRowState extends State<_HeaderRow> {
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Top row: Avatar + Name + Notification
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Avatar + Name
            GestureDetector(
              onTap: () {
                // TODO: Navigate to profile or settings
              },
              child: Row(
                children: [
                  // Avatar with border
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // User name
                  Text(
                    widget.userName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Notification icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                onPressed: () {
                  // TODO: Handle notification tap
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Search box with Dark Mode Icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search tips or customers...',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.colorScheme.primary,
                ),
                // Dark Mode icon inside search field
                suffixIcon: IconButton(
                  icon: Icon(
                    _darkModeEnabled
                        ? Icons.wb_sunny   // sun for light mode
                        : Icons.nightlight_round, // crescent moon for dark
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() => _darkModeEnabled = !_darkModeEnabled);
                    themeNotifier.toggleTheme(_darkModeEnabled);
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
