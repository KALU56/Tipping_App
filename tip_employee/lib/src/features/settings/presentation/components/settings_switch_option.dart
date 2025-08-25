part of '../../settings.dart';

class SettingsSwitchOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchOption({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
