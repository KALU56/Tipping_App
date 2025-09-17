part of '../../settings.dart';


class BankDropdown extends StatefulWidget {
  final String? initialValue;
  final List<Bank> banks;
  final ValueChanged<String?> onChanged;
  final String? hint;

  const BankDropdown({
    Key? key,
    this.initialValue,
    required this.banks,
    required this.onChanged,
    this.hint,
  }) : super(key: key);

  @override
  _BankDropdownState createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _initializeValue();
  }

  void _initializeValue() {
    debugPrint('🔍 Initializing BankDropdown with initialValue: "${widget.initialValue}"');
    debugPrint('🏦 Available banks: ${widget.banks.length}');
    
    if (widget.initialValue != null && widget.banks.isNotEmpty) {
      // Check if initial value exists in banks
      final matchingBank = widget.banks.firstWhere(
        (bank) => bank.code == widget.initialValue,
        orElse: () => Bank(name: '', code: ''), // Dummy bank for no match
      );
      
      if (matchingBank.name.isNotEmpty) {
        _selectedValue = widget.initialValue;
        debugPrint('✅ Initial bank found: ${matchingBank.name} (${matchingBank.code})');
      } else {
        debugPrint('⚠️ Initial bank code "${widget.initialValue}" not found in banks list');
        _selectedValue = null;
      }
    } else {
      _selectedValue = null;
      debugPrint('ℹ️ No initial value or empty banks list');
    }
  }

  @override
  void didUpdateWidget(covariant BankDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-initialize only if banks list changes significantly
    if (oldWidget.banks.length != widget.banks.length ||
        oldWidget.initialValue != widget.initialValue) {
      debugPrint('🔄 BankDropdown updated, re-initializing...');
      _initializeValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Always ensure value exists in items or is null
    final safeValue = _getSafeValue();
    
    debugPrint('🏦 Building dropdown - safeValue: "${safeValue}", banks: ${widget.banks.length}');

    return DropdownButtonFormField<String>(
      key: ValueKey('bank_dropdown_${safeValue ?? "null"}'),
      value: safeValue,
      decoration: const InputDecoration(
        labelText: "Select Bank",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.account_balance),
        errorText: null,
      ),
      hint: safeValue == null
          ? (widget.hint != null ? Text(widget.hint!) : const Text("Choose a bank"))
          : null,
      isExpanded: true,
      items: _buildSafeItems(),
      onChanged: (value) {
        debugPrint('🔄 Bank selected: "$value"');
        
        // Update local state first
        setState(() {
          _selectedValue = value;
        });
        
        // Notify parent after the frame is stable
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            debugPrint('📤 Notifying parent of bank selection: "$value"');
            widget.onChanged(value);
          }
        });
      },
      validator: (value) {
        if (value == null && widget.banks.isNotEmpty) {
          return 'Please select a bank';
        }
        return null;
      },
    );
  }

  String? _getSafeValue() {
    if (_selectedValue == null) return null;
    
    // Double-check if the value still exists in the current banks list
    final bankExists = widget.banks.any((bank) => bank.code == _selectedValue);
    
    if (!bankExists) {
      debugPrint('⚠️ Selected bank code "$_selectedValue" no longer exists in banks list');
      _selectedValue = null;
      return null;
    }
    
    return _selectedValue;
  }

  List<DropdownMenuItem<String>> _buildSafeItems() {
    if (widget.banks.isEmpty) {
      debugPrint('⚠️ No banks available, showing empty state');
      return [
        const DropdownMenuItem<String>(
          value: null,
          child: Text(
            "No banks available",
            style: TextStyle(color: Colors.grey),
          ),
        )
      ];
    }

    debugPrint('✅ Building ${widget.banks.length} dropdown items');
    return widget.banks.map((bank) {
      return DropdownMenuItem<String>(
        key: ValueKey(bank.code),
        value: bank.code,
        child: Row(
          children: [
            Icon(
              Icons.account_balance, 
              size: 20, 
              color: Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                bank.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}