part of '../../home.dart';

class _HeaderRow extends StatefulWidget {
  const _HeaderRow({Key? key}) : super(key: key);

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final user = state.user;

                final fullName = user != null
                    ? "${user.firstname} ${user.lastname}".trim()
                    : "Guest";

                final profileImage = user?.imageUrl?.isNotEmpty == true
                    ? NetworkImage(user!.imageUrl!)
                    : const AssetImage('assets/images/avatar.png')
                        as ImageProvider;

                return GestureDetector(
                  onTap: () {
                    // Navigate to profile page later if needed
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: profileImage,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        fullName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Notification button
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
                icon: Icon(Icons.notifications_none,
                    color: theme.colorScheme.primary),
                onPressed: () {},
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Search box
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
                prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    _darkModeEnabled
                        ? Icons.wb_sunny
                        : Icons.nightlight_round,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() => _darkModeEnabled = !_darkModeEnabled);
                    themeNotifier.toggleTheme(_darkModeEnabled);
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                context.read<HomeBloc>().add(SearchTips(value));
              },
            ),
          ),
        ),
      ],
    );
  }
}
