import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';

class SendMoneyArgs {
  final String accountNumber;
  final double amount;
  final Currency currency;

  SendMoneyArgs({
    required this.accountNumber,
    required this.amount,
    required this.currency,
  });
}
