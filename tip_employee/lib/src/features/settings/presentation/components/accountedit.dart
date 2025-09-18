part of '../../settings.dart';

class AccountEditDialog extends StatefulWidget {
  final String? businessName;
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final List<Bank> banks;

  const AccountEditDialog({
    this.businessName,
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
  late TextEditingController _businessController;
  late TextEditingController _numberController;
  late TextEditingController _nameController;
  String? _selectedBankCode;

  @override
  void initState() {
    super.initState();
    _businessController = TextEditingController(text: widget.businessName ?? '');
    _numberController = TextEditingController(text: widget.accountNumber ?? '');
    _nameController = TextEditingController(text: widget.accountName ?? '');
    _selectedBankCode = widget.bankCode;
  }

  @override
  void dispose() {
    _businessController.dispose();
    _numberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _triggerAccountResolution(String accountNumber) {
    if (accountNumber.length >= 6 && _selectedBankCode != null) {
      context.read<SettingBloc>().add(ResolveAccount(
            accountNumber: accountNumber,
            bankCode: _selectedBankCode!,
          ));
    }
  }

  bool _validateForm() {
    if (_businessController.text.trim().isEmpty) return _showError('Enter business name');
    if (_nameController.text.trim().isEmpty) return _showError('Enter account name');
    if (_numberController.text.trim().isEmpty) return _showError('Enter account number');
    if (_selectedBankCode == null) return _showError('Select a bank');
    return true;
  }

  bool _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is BankAccountUpdated) Navigator.pop(context);
        if (state is AccountResolved) {
          if (state.accountName != null) _nameController.text = state.accountName!;
        }
        if (state is AccountResolutionError) {
          debugPrint('Resolution failed: ${state.message}');
        }
      },
      builder: (context, state) {
        final isUpdating = state is BankAccountUpdating;
        final isResolving = state is AccountResolving;

        return AlertDialog(
          title: const Text('Update Bank Account'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Business Name Field
                TextField(
                  controller: _businessController,
                  decoration: const InputDecoration(
                    labelText: 'Business Name',
                    border: OutlineInputBorder(),
                  ),
                  enabled: !isUpdating,
                ),
                const SizedBox(height: 16),
                // Account Name Field
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Account Name',
                    border: const OutlineInputBorder(),
                    helperText: isResolving ? 'Detecting account details...' : null,
                  ),
                  enabled: !isUpdating,
                ),
                const SizedBox(height: 16),
                // Account Number Field
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'Account Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  enabled: !isUpdating,
                  onChanged: _triggerAccountResolution,
                ),
                const SizedBox(height: 16),
                // Bank Dropdown
                BankDropdown(
                  initialValue: _selectedBankCode,
                  banks: widget.banks,
                  accountNumber: _numberController.text,
                  onBankChanged: (code) => setState(() => _selectedBankCode = code),
                  onAccountNameResolved: (name) {
                    if (name != null && mounted) _nameController.text = name;
                  },
                  isResolving: isResolving,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isUpdating ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: isUpdating
                  ? null
                  : () {
                      if (_validateForm()) {
                        context.read<SettingBloc>().add(UpdateBankAccount(
                              BankAccountRequest(
                                businessName: _businessController.text.trim(), // ✅ Added
                                accountName: _nameController.text.trim(),
                                accountNumber: _numberController.text.trim(),
                                bankCode: int.tryParse(_selectedBankCode ?? '') ?? 0,
                              ),
                            ));
                      }
                    },
              child: isUpdating ? const CircularProgressIndicator() : const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
