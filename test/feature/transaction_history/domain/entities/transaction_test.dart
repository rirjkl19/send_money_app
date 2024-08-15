import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

void main() {
  final date = DateTime.now();
  group('Transaction', () {
    test('should should show the correct amount label', () {
      final transaction = Transaction(
        id: '1',
        amount: 100,
        type: TransactionType.deposit,
        currency: Currency.php,
        receiver: User(id: '1', name: 'John Doe', walletId: '1'),
        source: User(id: '2', name: 'Jane Doe', walletId: '2'),
        date: date,
      );
      expect(transaction.amountLabel, '₱100.00');
    });
  });
}
