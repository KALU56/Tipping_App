part of '../../settings.dart';
class AccountEditDialog extends StatefulWidget {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final List<Bank> banks;

  const AccountEditDialog({
    this.accountNumber,
    this.accountName,
    this.bankCode,
    required this.banks,
    Key? key,
  }) : super(key: key);

  @override
  _AccountEditDialogState createState() => _AccountEditDialogState();
}

class _AccountEditDialogState extends State<AccountEditDialog> {
  late TextEditingController _numberController;
  late TextEditingController _nameController;
  String? _selectedBankCode;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController(text: widget.accountNumber ?? '');
    _nameController = TextEditingController(text: widget.accountName ?? '');
    _selectedBankCode = widget.bankCode;
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is BankAccountUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bank account updated successfully!')),
          );
          Navigator.pop(context);
        }
        if (state is BankAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is BankAccountUpdating;

        return AlertDialog(
          title: const Text("Update Bank Account"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Account Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: "Account Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedBankCode,
                decoration: const InputDecoration(
                  labelText: "Select Bank",
                  border: OutlineInputBorder(),
                ),
                items: widget.banks.map((bank) {
                  return DropdownMenuItem<String>(
                    value: bank.code,
                    child: Text(bank.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBankCode = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_nameController.text.isEmpty ||
                          _numberController.text.isEmpty ||
                          _selectedBankCode == null) return;

                      final request = BankAccountRequest(
                        accountName: _nameController.text,
                        accountNumber: _numberController.text,
                        bankCode: _selectedBankCode,
                      );

                      context.read<SettingBloc>().add(UpdateBankAccount(request));
                    },
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
