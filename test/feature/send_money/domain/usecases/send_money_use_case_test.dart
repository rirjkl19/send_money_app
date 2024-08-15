import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';
import 'package:money_send_app/src/features/send_money/domain/entities/send_money_args.dart';
import 'package:money_send_app/src/features/send_money/domain/usecases/send_money_use_case.dart';
import 'package:money_send_app/src/features/transaction_history/data/dto/transaction_dto.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  final now = DateTime.now();
  late TransactionRepository transactionRepository;
  late UserRepository userRepository;
  late SendMoneyArgs sendMoneyArgs;
  late SendMoneyUseCase useCase;
  final stubTransactionDto = TransactionDto(
    id: '1',
    type: TransactionType.deposit,
    source: UserDto(id: '1', name: 'John Doe', walletId: '1'),
    receiver: UserDto(id: '2', name: 'Jane Doe', walletId: '2'),
    amount: 100.00,
    currency: Currency.php,
    date: now,
  );

  final stubTransactionResponse = Transaction(
    id: '1',
    type: TransactionType.deposit,
    source: User(id: '1', name: 'John Doe', walletId: '1'),
    receiver: User(id: '2', name: 'Jane Doe', walletId: '2'),
    amount: 100.00,
    currency: Currency.php,
    date: now,
  );

  group('SendMoneyUseCase', () {
    setUpAll(() {
      transactionRepository = MockTransactionRepository();
      userRepository = MockUserRepository();
      sendMoneyArgs = SendMoneyArgs(
        accountNumber: '2',
        amount: 100.00,
        currency: Currency.php,
      );

      registerFallbackValue(TransactionDto(
        id: '1',
        type: TransactionType.deposit,
        source: UserDto(id: '1', name: 'John Doe', walletId: '1'),
        receiver: UserDto(id: '2', name: 'Jane Doe', walletId: '2'),
        amount: 100.00,
        currency: Currency.php,
        date: now,
      ));

      useCase = SendMoneyUseCase(
        transactionRepository: transactionRepository,
        userRepository: userRepository,
      );
    });
    test('should send money to recipient', () async {
      // Return the current user
      when(() => userRepository.getCurrentUser())
          .thenAnswer((_) async => UserDto(id: '1', name: 'John Doe', walletId: '1'));

      // Return the recipient user
      when(() => userRepository.getUser(sendMoneyArgs.accountNumber))
          .thenAnswer((_) async => UserDto(id: '2', name: 'Jane Doe', walletId: '2'));

      // Return the transaction
      when(() => transactionRepository.sendMoney(any()))
          .thenAnswer((_) async => stubTransactionDto);

      // Call the use case
      final result = await useCase(sendMoneyArgs);

      // Verify the result
      expect(result, stubTransactionResponse);
      verify(() => userRepository.getCurrentUser()).called(1);
      verify(() => userRepository.getUser(sendMoneyArgs.accountNumber)).called(1);
      verify(() => transactionRepository.sendMoney(any())).called(1);
      verifyNoMoreInteractions(transactionRepository);
    });

    test('should return AppError upon failure to send money ', () async {
      when(() => userRepository.getCurrentUser())
          .thenAnswer((_) async => UserDto(id: '1', name: 'John Doe', walletId: '1'));
      when(() => userRepository.getUser(sendMoneyArgs.accountNumber))
          .thenAnswer((_) async => UserDto(id: '2', name: 'Jane Doe', walletId: '2'));
      when(() => transactionRepository.sendMoney(any()))
          .thenAnswer((_) => throw AppError(message: 'Failed to send money'));

      expect(useCase(sendMoneyArgs), throwsA(isA<AppError>()));
      verifyNoMoreInteractions(transactionRepository);
    });
  });
}
