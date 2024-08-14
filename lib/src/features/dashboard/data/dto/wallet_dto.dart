import 'dart:convert';

import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';

class WalletDto {
  WalletDto({required this.balance, required this.currency});
  final double balance;
  final String currency;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'balance': balance,
      'currency': currency,
    };
  }

  factory WalletDto.fromMap(Map<String, dynamic> map) {
    return WalletDto(
      balance: map['balance'] as double,
      currency: map['currency'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletDto.fromJson(String source) =>
      WalletDto.fromMap(json.decode(source) as Map<String, dynamic>);

  Wallet toEntity() {
    return Wallet(balance: balance, currency: currency);
  }
}
