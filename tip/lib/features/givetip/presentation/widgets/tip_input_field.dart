import 'package:flutter/material.dart';

class TipInputField extends StatelessWidget {
  final TextEditingController controller;

  const TipInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter tip amount',
        border: OutlineInputBorder(),
      ),
    );
  }
}
