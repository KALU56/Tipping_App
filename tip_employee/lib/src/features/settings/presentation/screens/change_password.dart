part of '../../settings.dart';

class ChangePasswordScreen extends StatefulWidget {
  final UserRepository repository;

  const ChangePasswordScreen({super.key, required this.repository});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Old Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your old password" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.length < 6 ? "Password must be 6+ chars" : null,
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);
                          await widget.repository.updatePassword(
                            _oldPasswordController.text,
                            _newPasswordController.text,
                          );
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Password updated successfully")),
                            );
                            Navigator.pop(context);
                          }
                        }
                        setState(() => _isLoading = false);
                      },
                      child: const Text("Update Password"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
