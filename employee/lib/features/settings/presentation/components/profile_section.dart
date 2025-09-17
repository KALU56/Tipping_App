part of '../../settings.dart';

class ProfileSection extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        User? user;
        if (state is ProfileLoaded) {
          user = state.user;
        }

        final profileImage = (user != null &&
                user.imageUrl != null &&
                user.imageUrl!.isNotEmpty)
            ? NetworkImage(user.imageUrl!)
            : null;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImage,
                  child: profileImage == null
                      ? const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null
                          ? "${user.firstname} ${user.lastname}"
                          : "Loading...",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
