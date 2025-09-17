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

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print('HeaderRow BlocBuilder: state=$state');

        String fullName = "Guest";
        ImageProvider? profileImage;

        if (state is HomeLoading) {
          fullName = "Loading...";
        } else if (state is ProfileLoaded) {
          fullName = state.profile.fullName;
          profileImage = state.profile.imageUrl != null && state.profile.imageUrl!.isNotEmpty
              ? NetworkImage(state.profile.imageUrl!)
              : null;
        } else if (state is ProfileError) {
          fullName = "Guest (Error: ${state.message})"; // Show error in UI
        }

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: profileImage,
                      child: profileImage == null
                          ? Icon(
                              Icons.person,
                              size: 20,
                              color: theme.colorScheme.onPrimary,
                            )
                          : null,
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
                IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search tips or customers...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                  prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
                ),
                onChanged: (value) {
                  // Handle search later if needed
                },
              ),
            ),
          ],
        );
      },
    );
  }
}