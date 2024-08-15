import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';

class Wallet {
  const Wallet({required this.balance, required this.currency});

  final double balance;
  final Currency currency;

  /// The balance as a string with 2 decimal places.
  String get balanceAsString => balance.toStringAsFixed(2);

  /// The balance (with 2 decimal places) with the currency symbol.
  String get balanceWithCurrency => '${currency.symbol}$balanceAsString';

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;
    return other.balance == balance && other.currency == currency;
  }

  @override
  int get hashCode => balance.hashCode ^ currency.hashCode;
}
