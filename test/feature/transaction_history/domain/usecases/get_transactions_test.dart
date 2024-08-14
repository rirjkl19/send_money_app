import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';
import 'package:money_send_app/src/features/transaction_history/domain/usecases/get_transactions.dart';

class MockTransactionsRepository extends Mock implements TransactionRepository {}

void main() {
  const self = User(id: '1', name: 'John Doe');

  late GetTransactions useCase;
  late TransactionRepository repository;

  setUp(() {
    repository = MockTransactionsRepository();
    useCase = GetTransactions(repository);
  });

  test('Should get transactions from the repository', () async {
    when(() => repository.getTransactions()).thenAnswer((_) async => [
          Transaction(
            id: '1',
            amount: 100,
            currency: Currency.php,
            type: TransactionType.deposit,
            sender: self,
            receiver: const User(id: '2', name: 'Jane Doe'),
            date: DateTime(2021, 1, 1),
          ),
          Transaction(
            id: '2',
            amount: 200,
            currency: Currency.php,
            type: TransactionType.withdraw,
            sender: const User(id: '2', name: 'Jane Doe'),
            receiver: self,
            date: DateTime(2021, 1, 1),
          ),
          Transaction(
            id: '3',
            amount: 100,
            currency: Currency.php,
            type: TransactionType.deposit,
            sender: self,
            receiver: const User(id: '3', name: 'Jack Doe'),
            date: DateTime(2021, 1, 1),
          ),
        ]);
    final result = await useCase();
    expect(result.length, 3);
    verify(() => repository.getTransactions());
    verifyNoMoreInteractions(repository);
  });
}
