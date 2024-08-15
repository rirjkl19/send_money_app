import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/usecases/get_wallet_use_case.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockWalletRepository extends Mock implements WalletRepository {}

void main() {
  late GetWalletUseCase useCase;
  late WalletRepository walletRepository;
  late UserRepository userRepository;
  late UserDto userDtoStub;

  setUp(() {
    walletRepository = MockWalletRepository();
    userRepository = MockUserRepository();
    useCase = GetWalletUseCase(
      walletRepository: walletRepository,
      userRepository: userRepository,
    );
    userDtoStub = UserDto(id: '1', name: 'John Doe', walletId: '1');
  });

  test('Should get wallet balance from the repository', () async {
    when(() => userRepository.getCurrentUser()).thenAnswer((_) async => userDtoStub);
    when(() => walletRepository.getWallet('1'))
        .thenAnswer((_) async => const WalletDto(id: '1', balance: 500.0, currency: 'PHP'));

    final result = await useCase();

    expect(result, const Wallet(id: '1', balance: 500.0, currency: Currency.php));
    verify(() => userRepository.getCurrentUser());
    verify(() => walletRepository.getWallet('1'));
    verifyNoMoreInteractions(walletRepository);
  });

  test('Should throw an AppError when getting wallet balance fails', () async {
    when(() => userRepository.getCurrentUser()).thenAnswer((_) async => userDtoStub);
    when(() => walletRepository.getWallet('1'))
        .thenAnswer((_) async => throw AppError(message: 'Failed to get wallet balance'));

    expect(useCase(), throwsA(isA<AppError>()));
    verify(() => userRepository.getCurrentUser());
    verifyNoMoreInteractions(walletRepository);
  });

  test('Should throw an AppError when getting current user fails', () async {
    when(() => userRepository.getCurrentUser())
        .thenAnswer((_) async => throw AppError(message: 'Failed to get current user'));

    expect(useCase(), throwsA(isA<AppError>()));
    verify(() => userRepository.getCurrentUser());
    verifyNoMoreInteractions(walletRepository);
  });
}
