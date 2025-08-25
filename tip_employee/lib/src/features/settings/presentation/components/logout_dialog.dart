part of '../../settings.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to log out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Logout"),
        ),
      ],
    );
  }
}
