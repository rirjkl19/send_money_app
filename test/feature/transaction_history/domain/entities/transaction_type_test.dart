import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

void main() {
  group('TransactionType', () {
    test('Deposit should return the correct label', () {
      expect(TransactionType.deposit.label, 'Deposit');
    });

    test('Withdraw should return the correct label', () {
      expect(TransactionType.withdraw.label, 'Withdraw');
    });

    test('Deposit should return the correct transaction label', () {
      expect(TransactionType.deposit.transactionLabel, 'Cash in transaction using ');
    });

    test('Withdraw should return the correct transaction label', () {
      expect(TransactionType.withdraw.transactionLabel, 'Sent money to ');
    });
  });
}
