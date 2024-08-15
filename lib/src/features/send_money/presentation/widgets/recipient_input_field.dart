import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountNumberInputField extends StatelessWidget {
  const AccountNumberInputField({
    this.currentUserId,
    super.key,
    this.controller,
    this.label = 'Account Number',
    this.hint = 'ex. 123',
    this.enabled = true,
  });

  /// The current user id.
  ///
  /// This is used to validate that the recipient account number is not the same as the current user's account number.
  final String? currentUserId;

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
        if (value == currentUserId) return 'You cannot send money to yourself';
        return null;
      },
    );
  }
}
