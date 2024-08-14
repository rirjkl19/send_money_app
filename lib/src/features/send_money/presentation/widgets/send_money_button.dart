import 'package:flutter/material.dart';
import 'package:money_send_app/src/core/configurations/app_widget_state_resolver.dart';

class SendMoneyButton extends StatelessWidget {
  const SendMoneyButton({super.key, this.isButtonEnabled = false});

  final bool isButtonEnabled;

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
        onPressed: isButtonEnabled ? () {} : null,
        child: const Text('Send', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
