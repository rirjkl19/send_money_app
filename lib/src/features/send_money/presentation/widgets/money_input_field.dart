import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_send_app/src/core/utilities/app_regex.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';

class MoneyInputField extends StatelessWidget {
  const MoneyInputField({
    super.key,
    this.enabled = true,
    this.controller,
    required this.prefix,
    this.labelText = 'Amount',
    this.hintText = 'Enter amount',
    this.customValidator,
    this.wallet,
  });

  final bool enabled;
  final TextEditingController? controller;
  final Widget prefix;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String?>? customValidator;

  /// The amount in the wallet.
  ///
  /// If provided, the validator will check if the amount entered is greater than the wallet amount.
  final Wallet? wallet;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      inputFormatters: [FilteringTextInputFormatter.allow(AppRegex.amountInput)],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: customValidator ??
          (value) {
            if (wallet != null && value!.isEmpty) {
              return 'Amount is required. You have ${wallet?.balanceLabel}';
            }
            if (value!.isEmpty) return 'Please enter an amount.';
            if (wallet?.balance == 0) return 'You have insufficient balance.';
            if (wallet != null && double.parse(value) > wallet!.balance) {
              return 'You only have ${wallet?.balanceLabel} in your wallet.';
            }
            return null;
          },
      decoration: InputDecoration(
        prefix: wallet == null ? null : Text(wallet!.currency.symbol),
        prefixStyle: const TextStyle(color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onChanged: customValidator,
    );
  }
}
