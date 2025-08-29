import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TipInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;

  const TipInputField({
    super.key,
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'enter_tip_amount'.tr(),
        border: const OutlineInputBorder(),
        errorText: errorText,
      ),
    );
  }
}
