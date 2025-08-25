part of '../../settings.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final UserRepository repository;

  const ProfileDetailsScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Details")),
      body: FutureBuilder<UserProfile>(
        future: repository.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No profile data found"));
          }

          final profile = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(profile.avatar),
                ),
                const SizedBox(height: 16),
                Text(profile.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(profile.role,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                const Divider(height: 32),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text("Email"),
                  subtitle: Text("${profile.name.toLowerCase()}@example.com"),
                ),
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text("Phone"),
                  subtitle: const Text("+251 900 000 000"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
