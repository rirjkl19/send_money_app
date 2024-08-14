// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Wallet {
  const Wallet({required this.balance, required this.currency});

  final double balance;
  final String currency;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'balance': balance,
      'currency': currency,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      balance: map['balance'] as double,
      currency: map['currency'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) =>
      Wallet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;

    return other.balance == balance && other.currency == currency;
  }

  @override
  int get hashCode => balance.hashCode ^ currency.hashCode;
}
