import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

class Transaction {
  final String id;
  final TransactionType type;
  final String senderName;
  final String receiverName;
  final double amount;
  final Currency currency;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.type,
    required this.senderName,
    required this.receiverName,
    required this.amount,
    required this.currency,
    required this.date,
  });

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.senderName == senderName &&
        other.receiverName == receiverName &&
        other.amount == amount &&
        other.currency == currency &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        senderName.hashCode ^
        receiverName.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        date.hashCode;
  }
}
