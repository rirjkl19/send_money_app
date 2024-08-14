import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

class Transaction {
  final String id;
  final TransactionType type;
  final User sender;
  final User receiver;
  final double amount;
  final Currency currency;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.type,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.currency,
    required this.date,
  });

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.amount == amount &&
        other.currency == currency &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        date.hashCode;
  }
}
