import 'package:intl/intl.dart';

import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';

class Wallet {
  const Wallet({required this.id, required this.balance, required this.currency});

  final String id;
  final double balance;
  final Currency currency;

  String get balanceLabel => NumberFormat.currency(symbol: currency.symbol).format(balance);

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;

    return other.id == id && other.balance == balance && other.currency == currency;
  }

  @override
  int get hashCode => id.hashCode ^ balance.hashCode ^ currency.hashCode;
}
