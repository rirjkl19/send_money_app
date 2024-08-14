import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/core/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/data/dto/transaction_dto.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

void main() {
  const senderStub = UserDto(id: '1', name: 'John Doe');
  const receiverStub = UserDto(id: '2', name: 'Jane Doe');

  final transactionStub = TransactionDto(
    id: 'txn123',
    type: TransactionType.deposit,
    source: senderStub,
    receiver: receiverStub,
    amount: 100,
    currency: Currency.php,
    date: DateTime.fromMillisecondsSinceEpoch(1633795200000),
  );

  group('TransactionDto (Deposit)', () {
    test('toMap should return a correct map', () {
      final expectedMap = {
        'id': 'txn123',
        'type': 'deposit',
        'source': senderStub.toMap(),
        'receiver': receiverStub.toMap(),
        'amount': 100.0,
        'currency': 'PHP',
        'date': 1633795200000,
      };
      final result = transactionStub.toMap();
      expect(result, expectedMap);
    });

    test('fromMap should return a correct TransactionDto instance', () {
      final map = {
        'id': 'txn123',
        'type': 'deposit',
        'source': senderStub.toMap(),
        'receiver': receiverStub.toMap(),
        'amount': 100.0,
        'currency': 'PHP',
        'date': 1633795200000,
      };
      final result = TransactionDto.fromMap(map);
      expect(result.toEntity(), transactionStub.toEntity());
    });

    test('toJson should return a correct JSON string', () {
      final expectedJsonString = json.encode(transactionStub.toMap());
      final result = transactionStub.toJson();
      expect(result, expectedJsonString);
    });

    test('fromJson should return a correct TransactionDto instance', () {
      final jsonString = json.encode(transactionStub.toMap());
      final result = TransactionDto.fromJson(jsonString);
      expect(result, transactionStub);
    });

    test('fromJsonList should return a list of TransactionDto instances', () {
      final jsonListString = json.encode([transactionStub.toMap()]);
      final expectedList = [transactionStub];
      final result = TransactionDto.fromJsonList(jsonListString);
      expect(result, expectedList);
    });

    test('== operator and hashCode should work correctly', () {
      final anotherTransactionDto = TransactionDto(
        id: 'txn123',
        type: TransactionType.deposit,
        source: senderStub,
        receiver: receiverStub,
        amount: 100.0,
        currency: Currency.php,
        date: DateTime.fromMillisecondsSinceEpoch(1633795200000),
      );
      expect(transactionStub, anotherTransactionDto);
      expect(transactionStub, anotherTransactionDto);
    });

    test('toEntity should correctly convert to Transaction entity', () {
      final expectedEntity = Transaction(
        id: 'txn123',
        type: TransactionType.deposit,
        source: senderStub.toEntity(),
        receiver: receiverStub.toEntity(),
        amount: 100.0,
        currency: Currency.php,
        date: DateTime.fromMillisecondsSinceEpoch(1633795200000),
      );
      final result = transactionStub.toEntity();
      expect(result, expectedEntity);
    });
  });
}
