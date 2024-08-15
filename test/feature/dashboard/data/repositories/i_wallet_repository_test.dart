import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/remote_wallet_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';
import 'package:money_send_app/src/features/dashboard/data/repositories/i_wallet_repository.dart';

class MockWalletDataSource extends Mock implements RemoteWalletDataSource {}

void main() {
  const walletStub = '{"id": "1", "balance": 500, "currency": "PHP"}';
  late MockWalletDataSource mockRemoteDataSource;
  late IWalletRepository mockWalletRepository;

  setUp(() {
    mockRemoteDataSource = MockWalletDataSource();
    mockWalletRepository = IWalletRepository(walletDataSource: mockRemoteDataSource);
  });

  group('IWalletRepository', () {
    test('Should get wallet balance from the repository', () async {
      when(() => mockRemoteDataSource.getWallet(any()))
          .thenAnswer((_) async => Response(walletStub, 200));
      final result = await mockWalletRepository.getWallet('1');
      expect(result, const WalletDto(id: '1', balance: 500.0, currency: 'PHP'));
      verify(() => mockRemoteDataSource.getWallet('1'));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('Should throw an AppError when getting wallet balance fails', () async {
      when(() => mockRemoteDataSource.getWallet('1'))
          .thenAnswer((_) async => Response('Not Found', 404));
      expect(() async => await mockWalletRepository.getWallet('1'), throwsA(isA<AppError>()));
      verify(() => mockRemoteDataSource.getWallet('1'));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
