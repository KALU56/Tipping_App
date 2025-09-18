part of '../../settings.dart';
class BankDropdown extends StatefulWidget {
  final String? initialValue;
  final List<Bank> banks;
  final ValueChanged<String?> onBankChanged;
  final String accountNumber;
  final ValueChanged<String?>? onAccountNameResolved;
  final bool isResolving;

  const BankDropdown({
    Key? key,
    this.initialValue,
    required this.banks,
    required this.onBankChanged,
    required this.accountNumber,
    this.onAccountNameResolved,
    this.isResolving = false,
  }) : super(key: key);

  @override
  _BankDropdownState createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  String? _selectedValue;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant BankDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.accountNumber != widget.accountNumber) {
      _debounceAccountResolution();
    }

    if (oldWidget.initialValue != widget.initialValue) {
      _selectedValue = widget.initialValue;
    }
  }

  void _debounceAccountResolution() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 800), () {
      if (widget.accountNumber.length >= 6 && _selectedValue != null) {
        context.read<SettingBloc>().add(ResolveAccount(
              accountNumber: widget.accountNumber,
              bankCode: _selectedValue!,
            ));
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      decoration: InputDecoration(
        labelText: "Select Bank",
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.account_balance),
        suffixIcon: widget.isResolving
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
              )
            : null,
      ),
      hint: const Text("Choose a bank"),
      isExpanded: true,
      items: widget.banks.map((bank) {
        return DropdownMenuItem<String>(
          value: bank.code,
          child: Text(bank.name),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedValue = value);
        widget.onBankChanged(value);
      },
    );
  }
}
