part of '../../settings.dart';

class ProfileSection extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileSection({super.key, required this.onTap, required User user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        User? user;
        if (state is ProfileLoaded) {
          user = state.user;
        }

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
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
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
                    const SizedBox(height: 4),
                    Text(
                      user != null ? user.email : "",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 253, 252, 252),
                        fontSize: 14,
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
