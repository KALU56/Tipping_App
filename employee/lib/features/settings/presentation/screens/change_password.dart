part of '../../settings.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPasswordFields(theme),
            const SizedBox(height: 24),
            _buildPasswordRequirements(theme),
            const SizedBox(height: 24),
            _buildUpdateButton(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordFields(ThemeData theme) {
    return Column(
      children: [
        _buildPasswordField(
          controller: _currentPasswordController,
          label: 'Current Password',
          obscureText: _obscureCurrentPassword,
          toggleObscure: () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
          icon: Icons.lock,
        ),
        const SizedBox(height: 16),
        _buildPasswordField(
          controller: _newPasswordController,
          label: 'New Password',
          obscureText: _obscureNewPassword,
          toggleObscure: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
          icon: Icons.lock_outline,
        ),
        const SizedBox(height: 16),
        _buildPasswordField(
          controller: _confirmPasswordController,
          label: 'Confirm New Password',
          obscureText: _obscureConfirmPassword,
          toggleObscure: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          icon: Icons.lock_outline,
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback toggleObscure,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleObscure,
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Password must contain:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('• At least 8 characters'),
        Text('• One uppercase letter'),
        Text('• One number'),
        Text('• One special character'),
      ],
    );
  }

  Widget _buildUpdateButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _updatePassword,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Update Password'),
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated successfully')),
    );
    Navigator.pop(context);
  }
}
