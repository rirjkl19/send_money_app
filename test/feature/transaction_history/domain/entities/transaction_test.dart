import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

void main() {
  final date = DateTime.now();
  group('Transaction', () {
    test('should be able to create a transaction', () {
      final transaction = Transaction(
        id: '1',
        amount: 100,
        type: TransactionType.deposit,
        currency: Currency.php,
        receiverName: 'John Doe',
        senderName: 'Jane Doe',
        date: date,
      );

      expect(transaction.id, '1');
      expect(transaction.amount, 100);
      expect(transaction.type, TransactionType.deposit);
      expect(transaction.currency, Currency.php);
      expect(transaction.receiverName, 'John Doe');
      expect(transaction.senderName, 'Jane Doe');
      expect(transaction.date, date);
    });
  });
}
