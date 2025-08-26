part of '../../settings.dart';



class ProfileEditDialog extends StatefulWidget {
  const ProfileEditDialog({super.key});

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  final _repo = MockUserRepository();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _descController;
  late TextEditingController _accountController;

  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _repo.getProfile();
    setState(() {
      _user = user;
      _nameController = TextEditingController(text: user.name);
      _usernameController = TextEditingController(text: user.username);
      _emailController = TextEditingController(text: user.email);
      _descController = TextEditingController(text: user.description);
      _accountController = TextEditingController(text: user.accountNumber);
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final updated = _user!.copyWith(
      name: _nameController.text,
      username: _usernameController.text,
      email: _emailController.text,
      description: _descController.text,
      accountNumber: _accountController.text,
    );

    await _repo.updateProfile(updated);

    if (mounted) {
      Navigator.pop(context, updated); // close dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        AlertDialog(
          
          title: const Text("Edit Profile"),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
                  const SizedBox(height: 12),
                  TextFormField(controller: _usernameController, decoration: const InputDecoration(labelText: "Username")),
                  const SizedBox(height: 12),
                  TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
                  const SizedBox(height: 12),
                  TextFormField(controller: _descController, decoration: const InputDecoration(labelText: "Description")),
                  const SizedBox(height: 12),
                  TextFormField(controller: _accountController, decoration: const InputDecoration(labelText: "Account Number")),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text("Save"),
            ),
          ],
        ),
      ],
    );
  }
}
