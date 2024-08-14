import 'package:money_send_app/src/features/dashboard/data/data_sources/remote_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';

interface class IWalletRepository implements WalletRepository {
  const IWalletRepository({required this.remoteDataSource});

  final RemoteDataSource remoteDataSource;

  @override
  Future<WalletDto> getWallet() async {
    try {
      final response = await remoteDataSource.getWallet();
      return WalletDto.fromJson(response.body);
    } catch (e) {
      throw Exception('Data source error: $e');
    }
  }

  @override
  Future<WalletDto> updateWallet(Wallet wallet) {
    // TODO: implement updateWallet
    throw UnimplementedError();
  }
}
