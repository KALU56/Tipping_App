// part of '../../settings.dart';


// class _SettingState extends State<Setting> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<SettingBloc>().add(LoadProfile());
//     context.read<SettingBloc>().add(LoadBankAccount());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: BlocConsumer<SettingBloc, SettingState>(
//           listener: (context, state) {
//             if (state is SettingError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.message)),
//               );
//             }
//             if (state is PasswordChanged) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Password updated!")),
//               );
//             }
//             if (state is BankAccountUpdated) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Bank account updated!")),
//               );
//             }
//             if (state is LoggedOut) {
//               Navigator.of(context).popUntil((route) => route.isFirst);
//             }
//           },
//           builder: (context, state) {
//             if (state is SettingLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             User? user;
//             String? accountNumber;
//             String? accountName;
//             String? bankCode;

//             if (state is ProfileLoaded) {
//               user = state.user;
//             }
//             if (state is BankAccountLoaded) {
//               accountNumber = state.accountNumber;
//               accountName = state.accountName;
//               bankCode = state.bankCode;
//             }

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: ProfileSection(
//                     onTap: () {
//                       if (user != null) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ProfileDetailsScreen(user: user!),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Profile not loaded yet")),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     'Other Settings',
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     children: [
//                       SettingsOption(
//                         color: theme.colorScheme.primary,
//                         icon: Icons.person_outline,
//                         title: 'Edit Profile',
//                         onTap: () {
//                           if (user != null) {
//                             showDialog(
//                               context: context,
//                               barrierColor: Colors.transparent,
//                               builder: (_) => ProfileEditDialog(user: user!),
//                             ).then((updatedUser) {
//                               if (updatedUser != null) {
//                                 context.read<SettingBloc>().add(
//                                       UpdateProfile(updatedUser),
//                                     );
//                               }
//                             });
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Profile not loaded yet")),
//                             );
//                           }
//                         },
//                       ),
//                       // SettingsOption(
//                       //   color: theme.colorScheme.primary,
//                       //   icon: Icons.account_balance,
//                       //   title: 'Edit Bank Account',
//                       //   onTap: () {
//                       //     showDialog(
//                       //       context: context,
//                       //       barrierColor: Colors.transparent,
//                       //       builder: (_) => AccountEditDialog(
//                       //         accountNumber: accountNumber,
//                       //         accountName: accountName,
//                       //         bankCode: bankCode,
//                       //       ),
//                       //     ).then((result) {
//                       //       if (result != null) {
//                       //         context.read<SettingBloc>().add(
//                       //               UpdateBankAccount(
//                       //                 accountName: result['accountName'],
//                       //                 accountNumber: result['accountNumber'],
//                       //                 bankCode: result['bankCode'],
//                       //               ),
//                       //             );
//                       //       }
//                       //     });
//                       //   },
//                       // ),
//                       SettingsOption(
//                         color: theme.colorScheme.primary,
//                         icon: Icons.lock_outline,
//                         title: 'Password',
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             barrierColor: Colors.transparent,
//                             builder: (_) => ChangePasswordDialog(),
//                           );
//                         },
//                       ),
//                       SettingsOption(
//                         color: theme.colorScheme.primary,
//                         icon: Icons.info_outline,
//                         title: 'About Application',
//                         onTap: () {},
//                       ),
//                       SettingsOption(
//                         icon: Icons.delete_outline,
//                         title: 'Delete Account',
//                         onTap: () {
//                           // Add delete event if needed
//                         },
//                         isDestructive: true,
//                       ),
//                       const SizedBox(height: 24),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (_) => LogoutDialog(
//                                 onConfirm: () {
//                                   context.read<SettingBloc>().add(Logout());
//                                 },
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: theme.colorScheme.error,
//                             foregroundColor: theme.colorScheme.onError,
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text('Logout'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }