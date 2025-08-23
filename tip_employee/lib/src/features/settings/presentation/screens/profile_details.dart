part of '../../settings.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileSection(),
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
                      // ❌ Removed self-navigation
                      // Maybe navigate to a real profile edit screen here
                    },
                  ),
                  SettingsOption(
                    icon: Icons.lock_outline,
                    title: 'Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  SettingsSwitchOption(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  SettingsSwitchOption(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                  ),
                  const Divider(height: 32),
                  SettingsOption(
                    icon: Icons.info_outline,
                    title: 'About Application',
                    onTap: () {},
                  ),
                  SettingsOption(
                    icon: Icons.help_outline,
                    title: 'Help',
                    onTap: () {},
                  ),
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
                onPressed: _showLogoutDialog,
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

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => const LogoutDialog(),
    );
  }
}
