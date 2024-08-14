import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';

class Wallet {
  const Wallet({required this.balance, required this.currency});

  final double balance;
  final Currency currency;

  String get balanceAsString => balance.toStringAsFixed(2);

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;
    return other.balance == balance && other.currency == currency;
  }

  @override
  int get hashCode => balance.hashCode ^ currency.hashCode;
}
