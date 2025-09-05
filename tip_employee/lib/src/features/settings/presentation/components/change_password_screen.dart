part of '../../settings.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is PasswordChanged) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password changed successfully')),
          );
          Navigator.pop(context);
        } else if (state is SettingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is SettingLoading;

        return Center(
          child: Material(
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Change Password',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildPasswordField('Current Password', _currentPasswordController, _obscureCurrentPassword, () {
                        setState(() => _obscureCurrentPassword = !_obscureCurrentPassword);
                      }),
                      const SizedBox(height: 12),
                      _buildPasswordField('New Password', _newPasswordController, _obscureNewPassword, () {
                        setState(() => _obscureNewPassword = !_obscureNewPassword);
                      }),
                      const SizedBox(height: 12),
                      _buildPasswordField('Confirm New Password', _confirmPasswordController, _obscureConfirmPassword, () {
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                      }),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: isLoading ? null : _updatePassword,
                            child: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Update'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscure, VoidCallback toggle) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: toggle,
        ),
      ),
    );
  }

  void _updatePassword() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    context.read<SettingBloc>().add(
          ChangePassword(
            _currentPasswordController.text,
            _newPasswordController.text,
          ),
        );
  }
}
