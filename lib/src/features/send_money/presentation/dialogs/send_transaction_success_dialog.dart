import 'package:flutter/material.dart';
import 'package:money_send_app/src/core/utilities/app_dialog_helper.dart';
import 'package:money_send_app/src/core/utilities/app_widget_state_resolver.dart';

class SendTransactionSuccessDialog extends StatelessWidget with AppDialogHelper {
  const SendTransactionSuccessDialog({
    super.key,
    required this.accountNumber,
    required this.amountSent,
    this.onDone,
  });

  final String accountNumber;
  final String amountSent;
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
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 12),
              Text(
                "You've successfully sent $amountSent",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text('from your wallet to $accountNumber', textAlign: TextAlign.center),
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
                  child: const Text('Done', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
