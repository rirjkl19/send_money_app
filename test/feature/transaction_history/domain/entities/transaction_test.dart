import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/core/entities/user.dart';
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
        receiver: const User(id: '1', name: 'John Doe'),
        sender: const User(id: '2', name: 'Jane Doe'),
        date: date,
      );

      expect(transaction.id, '1');
      expect(transaction.amount, 100);
      expect(transaction.type, TransactionType.deposit);
      expect(transaction.currency, Currency.php);
      expect(transaction.receiver, const User(id: '1', name: 'John Doe'));
      expect(transaction.sender, const User(id: '2', name: 'Jane Doe'));
      expect(transaction.date, date);
    });
  });
}
