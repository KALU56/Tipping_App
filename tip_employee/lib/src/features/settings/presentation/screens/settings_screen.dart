part of '../../settings.dart';

class SettingsScreen extends StatefulWidget {
  final UserRepository repository;

  const SettingsScreen({super.key, required this.repository});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  late Future<UserProfile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = widget.repository.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<UserProfile>(
              future: _profileFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No profile found');
                }
                final profile = snapshot.data!;
                return ProfileSection(profile: profile);
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Other Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  SettingsOption(
                    icon: Icons.person_outline,
                    title: 'Profile Details',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileDetailsScreen(repository: widget.repository),
                        ),
                      );
                    },
                  ),
                  SettingsOption(
                    icon: Icons.lock_outline,
                    title: 'Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChangePasswordScreen(repository: widget.repository),
                        ),
                      );
                    },
                  ),
                  SettingsSwitchOption(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    value: _notificationsEnabled,
                    onChanged: (val) =>
                        setState(() => _notificationsEnabled = val),
                  ),
                  SettingsSwitchOption(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    value: _darkModeEnabled,
                    onChanged: (val) =>
                        setState(() => _darkModeEnabled = val),
                  ),
                  const Divider(height: 32),
                  SettingsOption(
                      icon: Icons.info_outline,
                      title: 'About Application',
                      onTap: () {}),
                  SettingsOption(icon: Icons.help_outline, title: 'Help', onTap: () {}),
                  SettingsOption(
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    onTap: () {},
                    isDestructive: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await widget.repository.logout();
                  if (mounted) {
                    showDialog(
                      context: context,
                      builder: (_) => const LogoutDialog(),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
