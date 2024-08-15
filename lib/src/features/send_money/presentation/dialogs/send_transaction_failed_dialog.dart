import 'package:flutter/material.dart';
import 'package:money_send_app/src/core/utilities/app_dialog_helper.dart';
import 'package:money_send_app/src/core/utilities/app_widget_state_resolver.dart';

class SendTransactionFailedDialog extends StatelessWidget with AppDialogHelper {
  const SendTransactionFailedDialog({
    super.key,
    this.onDone,
    required this.accountNumber,
    required this.amountSent,
  });

  final String amountSent;
  final String accountNumber;
  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 12),
              const Text(
                'Something went wrong',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'You might have entered a wrong account number',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 54,
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                      AppWidgetStateResolver.appColorResolver,
                    ),
                  ),
                  onPressed: onDone,
                  child: const Text('Ok', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
