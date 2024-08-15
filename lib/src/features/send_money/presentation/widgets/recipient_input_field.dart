import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountNumberInputField extends StatelessWidget {
  const AccountNumberInputField({
    super.key,
    this.controller,
    this.label = 'Account Number',
    this.hint = 'ex. 123456789',
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String label;
  final String hint;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter recipient account number';
        return null;
      },
    );
  }
}
