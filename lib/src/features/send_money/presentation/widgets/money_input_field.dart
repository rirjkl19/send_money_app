import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_send_app/src/core/utilities/app_regex.dart';

class MoneyInputField extends StatelessWidget {
  const MoneyInputField({
    super.key,
    this.controller,
    required this.prefix,
    this.labelText = 'Amount',
    this.hintText = 'Enter amount',
    this.customValidator,
  });

  final TextEditingController? controller;
  final Widget prefix;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String?>? customValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [FilteringTextInputFormatter.allow(AppRegex.amountInput)],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: customValidator ??
          (value) {
            if (value!.isEmpty) return 'Please enter an amount';
            return null;
          },
      decoration: InputDecoration(
        prefix: const Text('₱ '),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onChanged: customValidator,
    );
  }
}
