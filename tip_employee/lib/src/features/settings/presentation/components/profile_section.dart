part of '../../settings.dart';

class ProfileSection extends StatelessWidget {
  final UserProfile profile;

  const ProfileSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(profile.avatar),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(profile.role,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[600]),
        ],
      ),
    );
  }
}
