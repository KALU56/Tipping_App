part of '../../settings.dart';

class ProfileEditDialog extends StatefulWidget {
  final User user;
  const ProfileEditDialog({super.key, required this.user});

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;

  late TextEditingController _accountController;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.user.firstname);
    _lastnameController = TextEditingController(text: widget.user.lastname);

    _accountController =
        TextEditingController(text: widget.user.accountNumber);
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
 
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4)),
              ],
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Edit Profile',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField("First Name", _firstnameController),
                    const SizedBox(height: 12),
                    _buildTextField("Last Name", _lastnameController),
                    const SizedBox(height: 12),
         
                    const SizedBox(height: 12),
                    _buildTextField("Account Number", _accountController),
                    const SizedBox(height: 16),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) =>
          (v == null || v.isEmpty) ? "Please enter $label" : null,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _saveProfile,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;

    final updated = widget.user.copyWith(
      firstname: _firstnameController.text,
      lastname: _lastnameController.text,
 
      accountNumber: _accountController.text,
    );

    context.read<SettingBloc>().add(UpdateProfile(updated));
    Navigator.pop(context);
  }
}
