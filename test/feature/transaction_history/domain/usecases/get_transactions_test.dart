import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/transaction_history/data/dto/transaction_dto.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';
import 'package:money_send_app/src/features/transaction_history/domain/usecases/get_transactions_use_case.dart';

class MockTransactionsRepository extends Mock implements TransactionRepository {}

void main() {
  final self = UserDto(id: '1', name: 'John Doe', walletId: '1');
  final other = UserDto(id: '2', name: 'Jane Doe', walletId: '2');
  final another = UserDto(id: '3', name: 'Jack Doe', walletId: '3');

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
            source: self,
            receiver: other,
            date: DateTime(2021, 1, 1),
          ),
          TransactionDto(
            id: '2',
            amount: 200,
            currency: Currency.php,
            type: TransactionType.withdraw,
            source: other,
            receiver: self,
            date: DateTime(2021, 1, 1),
          ),
          TransactionDto(
            id: '3',
            amount: 100,
            currency: Currency.php,
            type: TransactionType.deposit,
            source: self,
            receiver: another,
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
        source: self.toEntity(),
        receiver: other.toEntity(),
        date: DateTime(2021, 1, 1),
      ),
      Transaction(
        id: '2',
        amount: 200,
        currency: Currency.php,
        type: TransactionType.withdraw,
        source: other.toEntity(),
        receiver: self.toEntity(),
        date: DateTime(2021, 1, 1),
      ),
      Transaction(
        id: '3',
        amount: 100,
        currency: Currency.php,
        type: TransactionType.deposit,
        source: self.toEntity(),
        receiver: another.toEntity(),
        date: DateTime(2021, 1, 1),
      )
    ]);
    verify(() => repository.getTransactions());
    verifyNoMoreInteractions(repository);
  });
}
