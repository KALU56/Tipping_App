

part of '../../settings.dart';
class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated!")),
      );
      Navigator.pop(context, updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}