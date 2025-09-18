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

    // Load initial bank/account info if needed
    context.read<SettingBloc>().add(LoadBankAccount());
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    final name = _nameController.text.trim();
    final number = _numberController.text.trim();

    if (name.isEmpty) return _showValidationError('Please enter account name');
    if (number.isEmpty) return _showValidationError('Please enter account number');
    if (_selectedBankCode == null) return _showValidationError('Please select a bank');

    return true;
  }

  bool _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
    return false;
  }

  void _onBankChanged(String? code) {
    setState(() => _selectedBankCode = code);
  }

  void _onAccountNameResolved(String? resolvedName) {
    if (resolvedName != null && resolvedName.isNotEmpty && mounted) {
      setState(() => _nameController.text = resolvedName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account name auto-filled: $resolvedName'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _triggerAccountResolution(String accountNumber) {
    if (accountNumber.length < 6 || _selectedBankCode == null) return;

    context.read<SettingBloc>().add(ResolveAccount(
      accountNumber: accountNumber,
      bankCode: _selectedBankCode!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is BankAccountUpdated) Navigator.pop(context);
        if (state is AccountResolved) _onAccountNameResolved(state.accountName);
        if (state is AccountResolutionError) debugPrint('Resolution failed: ${state.message}');
        if (state is BankAccountError)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}'), backgroundColor: Colors.red),
          );
      },
      builder: (context, state) {
        final isUpdating = state is BankAccountUpdating;
        final isResolving = state is AccountResolving;

        return AlertDialog(
          title: const Text("Update Bank Account"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Account Name
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Account Name',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.account_balance_wallet),
                    helperText: isResolving ? 'Detecting account details...' : null,
                  ),
                  textCapitalization: TextCapitalization.words,
                  enabled: !isUpdating,
                ),
                const SizedBox(height: 16),
                
                // Account Number
                TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    labelText: 'Account Number',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.numbers),
                    helperText: 'Enter 6+ digits to auto-detect bank and name',
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
                  onBankChanged: _onBankChanged,
                  onAccountNameResolved: _onAccountNameResolved,
                  isResolving: isResolving,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: isUpdating ? null : () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton.icon(
              onPressed: isUpdating
                  ? null
                  : () {
                      if (_validateForm()) {
                        context.read<SettingBloc>().add(UpdateBankAccount(
                              BankAccountRequest(
                                accountName: _nameController.text.trim(),
                                accountNumber: _numberController.text.trim(),
                                bankCode: _selectedBankCode,
                              ),
                            ));
                      }
                    },
              icon: isUpdating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.save),
              label: Text(isUpdating ? 'Updating...' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}
