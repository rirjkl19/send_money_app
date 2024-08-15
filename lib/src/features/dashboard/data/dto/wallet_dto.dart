import 'dart:convert';

import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';

class WalletDto {
  const WalletDto({required this.id, required this.balance, required this.currency});
  final String id;
  final double balance;
  final String currency;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'balance': balance,
      'currency': currency,
    };
  }

  factory WalletDto.fromMap(Map<String, dynamic> map) {
    return WalletDto(
      id: map['id'] as String,
      balance: map['balance'] is int ? map['balance'].toDouble() : map['balance'] as double,
      currency: map['currency'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletDto.fromJson(String source) =>
      WalletDto.fromMap(json.decode(source) as Map<String, dynamic>);

  Wallet toEntity() {
    return Wallet(id: id, balance: balance, currency: Currency.fromDto(currency));
  }

  @override
  bool operator ==(covariant WalletDto other) {
    if (identical(this, other)) return true;

    return other.id == id && other.balance == balance && other.currency == currency;
  }

  @override
  int get hashCode => id.hashCode ^ balance.hashCode ^ currency.hashCode;

  WalletDto copyWith({
    String? id,
    double? balance,
    String? currency,
  }) {
    return WalletDto(
      id: id ?? this.id,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
    );
  }
}
