part of '../../settings.dart';

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
