part of '../../settings.dart';

class _SettingState extends State<Setting> {
  @override
  void initState() {
    super.initState();
    // Load profile at startup
    context.read<SettingBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<SettingBloc, SettingState>(
          listener: (context, state) {
            if (state is SettingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is PasswordChanged) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Password updated!")),
              );
            }
            if (state is LoggedOut) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            if (state is BankAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            if (state is SettingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileLoaded) {
              final user = state.user;

              return Column(
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
                            builder: (_) => ProfileDetailsScreen(user: user),
                          ),
                        );
                      },
                      user: user,
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
                              builder: (_) => ProfileEditDialog(user: user),
                            ).then((updatedUser) {
                              if (updatedUser != null) {
                                context.read<SettingBloc>().add(UpdateProfile(updatedUser));
                              }
                            });
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
                              builder: (_) => ChangePasswordDialog(),
                            );
                          },
                        ),
                        SettingsOption(
                          color: theme.colorScheme.primary,
                          icon: Icons.info_outline,
                          title: 'About Application',
                          onTap: () {},
                        ),
                        SettingsOption(
                          color: theme.colorScheme.primary,
                          icon: Icons.account_balance_wallet_outlined,
                          title: 'Update Bank Account',
                          onTap: () {
                            // Load banks first
                            context.read<SettingBloc>().add(LoadBanks());

                            // Open dialog
                            showDialog(
                              context: context,
                              builder: (_) {
                                return BlocBuilder<SettingBloc, SettingState>(
                                  builder: (context, state) {
                                    List<Bank> banks = [];
                                    if (state is BankListLoaded) banks = state.banks;

                                    return AccountEditDialog(
                                      banks: banks,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        SettingsOption(
                          icon: Icons.delete_outline,
                          title: 'Delete Account',
                          onTap: () {},
                          isDestructive: true,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => LogoutDialog(
                                  onConfirm: () {
                                    context.read<SettingBloc>().add(Logout());
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.error,
                              foregroundColor: theme.colorScheme.onError,
                              padding: const EdgeInsets.symmetric(vertical: 8),
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
              );
            }

            return const Center(child: Text("No profile loaded"));
          },
        ),
      ),
    );
  }
}
