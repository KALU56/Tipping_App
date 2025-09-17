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
    
    debugPrint('📝 AccountEditDialog initialized with:');
    debugPrint('  - accountNumber: "${widget.accountNumber}"');
    debugPrint('  - accountName: "${widget.accountName}"');
    debugPrint('  - bankCode: "${widget.bankCode}"');
    debugPrint('  - banks count: ${widget.banks.length}');
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
    
    if (name.isEmpty) {
      _showValidationError('Please enter account name');
      return false;
    }
    if (number.isEmpty) {
      _showValidationError('Please enter account number');
      return false;
    }
    if (_selectedBankCode == null || _selectedBankCode!.isEmpty) {
      _showValidationError('Please select a bank');
      return false;
    }
    
    debugPrint('✅ Form validation passed');
    debugPrint('  - Name: "$name"');
    debugPrint('  - Number: "$number"');
    debugPrint('  - BankCode: "$_selectedBankCode"');
    
    return true;
  }

  void _showValidationError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _onBankSelected(String? bankCode) {
    setState(() {
      _selectedBankCode = bankCode;
    });
    debugPrint('📝 Dialog received bank selection: "$bankCode"');
  }

  @override
  Widget build(BuildContext context) {
    // Safety check for empty banks
    if (widget.banks.isEmpty) {
      return _buildErrorDialog("No banks available. Please try again later.");
    }

    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is BankAccountUpdated && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bank account updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
        if (state is BankAccountError && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is BankAccountUpdating;

        return AlertDialog(
          title: const Text("Update Bank Account"),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Account Name Field
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Account Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_balance_wallet),
                      errorText: null,
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  
                  // Account Number Field
                  TextField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                      labelText: "Account Number",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.numbers),
                      errorText: null,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 16),
                  
                  // Isolated Bank Dropdown
                  BankDropdown(
                    initialValue: _selectedBankCode,
                    banks: widget.banks,
                    onChanged: _onBankSelected,
                    hint: _selectedBankCode == null ? "Choose a bank" : null,
                  ),
                  
                  // Optional: Show warning if original bank code is invalid
                  if (_selectedBankCode == null && 
                      widget.bankCode != null && 
                      widget.banks.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber, 
                               color: Colors.orange[700], 
                               size: 16),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Original bank not available. Please select a new bank.',
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton.icon(
              onPressed: isLoading ? null : () {
                if (_validateForm()) {
                  final request = BankAccountRequest(
                    accountName: _nameController.text.trim(),
                    accountNumber: _numberController.text.trim(),
                    bankCode: _selectedBankCode,
                  );
                  
                  debugPrint('🚀 Submitting bank account update:');
                  debugPrint('  ${request.toJson()}');
                  
                  if (mounted) {
                    context.read<SettingBloc>().add(UpdateBankAccount(request));
                  }
                }
              },
              icon: isLoading 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2, 
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save, size: 18),
              label: Text(isLoading ? "Updating..." : "Update"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildErrorDialog(String message) {
    return AlertDialog(
      title: const Text("Error", style: TextStyle(color: Colors.red)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    );
  }
}