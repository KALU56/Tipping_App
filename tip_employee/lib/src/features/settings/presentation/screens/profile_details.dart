part of '../../settings.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final User user;
  const ProfileDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            const SizedBox(height: 16),
            Text(
              "${user.firstname} ${user.lastname}",
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user.work,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            _buildDetailItem(context, 'Email', user.email),
            _buildDetailItem(context, 'Firstname', user.firstname),
            _buildDetailItem(context, 'Lastname', user.lastname),
            _buildDetailItem(context, 'Account number', user.accountNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String title, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(value, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
