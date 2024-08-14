class Wallet {
  const Wallet({required this.balance, required this.currency});

  final double balance;
  final String currency;

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;
    return other.balance == balance && other.currency == currency;
  }

  @override
  int get hashCode => balance.hashCode ^ currency.hashCode;
}
