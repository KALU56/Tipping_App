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
        child: ListView(
          children: [
            // Circular profile picture (keeps image intact)
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: ClipOval(
                  child: Image(
                    image: user.imageUrl != null && user.imageUrl!.isNotEmpty
                        ? NetworkImage(user.imageUrl!)
                        : const AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                    fit: BoxFit.contain, // 👈 keeps the whole image visible
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Full name
            Text(
              "${user.firstname} ${user.lastname}",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Profile fields
            _buildDetailItem(context, 'Email', user.email),
            _buildDetailItem(context, 'Firstname', user.firstname),
            _buildDetailItem(context, 'Lastname', user.lastname),
            _buildDetailItem(context, 'Account Name', user.accountName ?? 'N/A'),
            _buildDetailItem(context, 'Account Number', user.accountNumber ?? 'N/A'),
            _buildDetailItem(context, 'Bank Code', user.bankCode ?? 'N/A'),
            _buildDetailItem(context, 'Tip Code', user.tipCode ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String title, String? value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Value
          Expanded(
            flex: 3,
            child: Text(
              value ?? 'N/A',
              style: theme.textTheme.bodyMedium,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
