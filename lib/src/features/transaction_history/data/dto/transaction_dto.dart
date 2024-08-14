// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:money_send_app/src/core/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

class TransactionDto {
  final String id;
  final TransactionType type;
  final UserDto sender;
  final UserDto receiver;
  final double amount;
  final Currency currency;
  final DateTime date;

  const TransactionDto({
    required this.id,
    required this.type,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.currency,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'sender': sender.toMap(),
      'receiver': receiver.toMap(),
      'amount': amount,
      'currency': currency.toDtoName,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory TransactionDto.fromMap(Map<String, dynamic> map) {
    return TransactionDto(
      id: map['id'] as String,
      type: TransactionType.values.byName(map['type']),
      sender: UserDto.fromMap(map['sender'] as Map<String, dynamic>),
      receiver: UserDto.fromMap(map['receiver'] as Map<String, dynamic>),
      amount: map['amount'] is int ? map['amount'].toDouble() : map['amount'] as double,
      currency: Currency.fromDto(map['currency']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionDto.fromJson(String source) =>
      TransactionDto.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<TransactionDto> fromJsonList(String source) {
    final List<Map<String, dynamic>> list =
        List<Map<String, dynamic>>.from(json.decode(source) as List);
    return list.map((e) => TransactionDto.fromMap(e)).toList();
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      type: type,
      senderName: sender.name,
      receiverName: receiver.name,
      amount: amount,
      currency: currency,
      date: date,
    );
  }

  @override
  bool operator ==(covariant TransactionDto other) {
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
