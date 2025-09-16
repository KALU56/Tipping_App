part of '../../settings.dart';

class AccountEditDialog extends StatefulWidget {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;

  const AccountEditDialog({
    this.accountNumber,
    this.accountName,
    this.bankCode,
    Key? key,
  }) : super(key: key);

  @override
  _AccountEditDialogState createState() => _AccountEditDialogState();
}

class _AccountEditDialogState extends State<AccountEditDialog> {
  late TextEditingController _numberController;
  late TextEditingController _nameController;
  String? _selectedBankCode;
  List<Map<String, dynamic>> _banks = [];
  bool _isLoadingBanks = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController(text: widget.accountNumber ?? '');
    _nameController = TextEditingController(text: widget.accountName ?? '');
    _selectedBankCode = widget.bankCode;
    _fetchBanks();
  }

  Future<void> _fetchBanks() async {
    setState(() {
      _isLoadingBanks = true;
      _errorMessage = null;
    });
    try {
      final response = await context.read<SettingBloc>().userSettingRepository.getBanks();
      setState(() {
        _banks = response;
        _isLoadingBanks = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingBanks = false;
        _errorMessage = 'Failed to load banks: $e';
      });
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text("Update Tip Account"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Account Name",
              border: OutlineInputBorder(),
              errorText: _nameController.text.isEmpty ? 'Required' : null,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _numberController,
            decoration: InputDecoration(
              labelText: "Account Number",
              border: OutlineInputBorder(),
              errorText: _numberController.text.isEmpty ? 'Required' : null,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          _isLoadingBanks
              ? const Center(child: CircularProgressIndicator())
              : DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Select Bank",
                    border: OutlineInputBorder(),
                    errorText: _selectedBankCode == null ? 'Please select a bank' : null,
                  ),
                  value: _selectedBankCode,
                  items: _banks.map((bank) {
                    return DropdownMenuItem<String>(
                      value: bank['code'],
                      child: Text(bank['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBankCode = value;
                    });
                  },
                ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: TextStyle(color: theme.colorScheme.error, fontSize: 12),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_numberController.text.isEmpty ||
                _nameController.text.isEmpty ||
                _selectedBankCode == null) {
              setState(() {}); // Trigger validation
              return;
            }
            Navigator.pop(context, {
              'accountName': _nameController.text,
              'accountNumber': _numberController.text,
              'bankCode': _selectedBankCode,
            });
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}