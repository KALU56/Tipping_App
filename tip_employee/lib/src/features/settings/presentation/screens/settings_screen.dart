part of '../../settings.dart';

class _SettingState extends State<Setting> {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // adaptive background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: ProfileSection(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileDetailsScreen(),
                    ),
                  );
                },
              ),
            ),

            // Other Settings Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Other Settings',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Settings Options
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  SettingsOption(
                    color: theme.colorScheme.primary,
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (_) => const ProfileEditDialog(),
                      );
                    },
                  ),
                  SettingsOption(
                    color: theme.colorScheme.primary,
                    icon: Icons.lock_outline,
                    title: 'Password',
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (_) => const ChangePasswordDialog(),
                      );
                    },
                  ),
                  // SettingsSwitchOption(
                  //   icon: Icons.notifications_none,
                  //   title: 'Notifications',
                  //   value: _notificationsEnabled,
                  //   onChanged: (value) {
                  //     setState(() => _notificationsEnabled = value);
                  //   },
                  // ),
                 
                  Divider(height: 32, color: theme.dividerColor),
                  SettingsOption(
                    color: theme.colorScheme.primary,
                    icon: Icons.info_outline,
                    title: 'About Application',
                    onTap: () {},
                  ),
                  SettingsOption(
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    onTap: () {},
                    isDestructive: true,
                  ),
                  const SizedBox(height: 24),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const LogoutDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                        foregroundColor: theme.colorScheme.onError,
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
          ],
        ),
      ),
    );
  }
}
