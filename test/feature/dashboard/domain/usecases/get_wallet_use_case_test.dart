import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/usecases/get_wallet_use_case.dart';

class MockWalletRepository extends Mock implements WalletRepository {}

void main() {
  late GetWalletUseCase useCase;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockWalletRepository = MockWalletRepository();
    useCase = GetWalletUseCase(walletRepository: mockWalletRepository);
  });

  test('Should get wallet balance from the repository', () async {
    when(() => mockWalletRepository.getWallet())
        .thenAnswer((_) async => const WalletDto(balance: 500, currency: 'PHP'));
    final result = await useCase();
    expect(result, const Wallet(balance: 500, currency: Currency.php));
    verify(() => mockWalletRepository.getWallet());
    verifyNoMoreInteractions(mockWalletRepository);
  });

  test('Should throw an AppError when getting wallet balance fails', () async {
    when(() => mockWalletRepository.getWallet()).thenThrow(AppError.network());
    expect(() async => await useCase(), throwsA(isA<AppError>()));
    verify(() => mockWalletRepository.getWallet());
    verifyNoMoreInteractions(mockWalletRepository);
  });
}
