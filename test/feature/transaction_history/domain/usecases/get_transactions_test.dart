import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_send_app/src/core/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/data/dto/transaction_dto.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';
import 'package:money_send_app/src/features/transaction_history/domain/usecases/get_transactions_use_case.dart';

class MockTransactionsRepository extends Mock implements TransactionRepository {}

void main() {
  const self = UserDto(id: '1', name: 'John Doe');

  late GetTransactionsUseCase useCase;
  late TransactionRepository repository;

  setUp(() {
    repository = MockTransactionsRepository();
    useCase = GetTransactionsUseCase(repository);
  });

  test('Should get list of transactions from the repository', () async {
    when(() => repository.getTransactions()).thenAnswer((_) async => [
          TransactionDto(
            id: '1',
            amount: 100,
            currency: Currency.php,
            type: TransactionType.deposit,
            sender: self,
            receiver: const UserDto(id: '2', name: 'Jane Doe'),
            date: DateTime(2021, 1, 1),
          ),
          TransactionDto(
            id: '2',
            amount: 200,
            currency: Currency.php,
            type: TransactionType.withdraw,
            sender: const UserDto(id: '2', name: 'Jane Doe'),
            receiver: self,
            date: DateTime(2021, 1, 1),
          ),
          TransactionDto(
            id: '3',
            amount: 100,
            currency: Currency.php,
            type: TransactionType.deposit,
            sender: self,
            receiver: const UserDto(id: '3', name: 'Jack Doe'),
            date: DateTime(2021, 1, 1),
          ),
        ]);
    final result = await useCase();
    expect(result, <Transaction>[
      Transaction(
        id: '1',
        amount: 100,
        currency: Currency.php,
        type: TransactionType.deposit,
        senderName: self.name,
        receiverName: 'Jane Doe',
        date: DateTime(2021, 1, 1),
      ),
      Transaction(
        id: '2',
        amount: 200,
        currency: Currency.php,
        type: TransactionType.withdraw,
        senderName: 'Jane Doe',
        receiverName: self.name,
        date: DateTime(2021, 1, 1),
      ),
      Transaction(
        id: '3',
        amount: 100,
        currency: Currency.php,
        type: TransactionType.deposit,
        senderName: self.name,
        receiverName: 'Jack Doe',
        date: DateTime(2021, 1, 1),
      )
    ]);
    verify(() => repository.getTransactions());
    verifyNoMoreInteractions(repository);
  });
}
