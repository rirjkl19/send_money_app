import 'package:flutter/material.dart';
import 'package:money_send_app/src/core/utilities/app_widget_state_resolver.dart';

class SendMoneyButton extends StatelessWidget {
  const SendMoneyButton({
    super.key,
    this.isButtonEnabled = false,
    this.onPressed,
    this.isLoading = false,
  });

  final bool isButtonEnabled;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            AppWidgetStateResolver.appColorResolver,
          ),
        ),
        onPressed: isButtonEnabled ? onPressed : null,
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : const Text('Send', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
