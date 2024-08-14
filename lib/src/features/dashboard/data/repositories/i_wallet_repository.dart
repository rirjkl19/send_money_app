import 'dart:io';

import 'package:money_send_app/src/core/configurations/app_error.dart';
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
      if (response.statusCode != 200) {
        throw AppError(message: 'Failed to get wallet balance');
      }
      return WalletDto.fromJson(response.body);
    } on SocketException {
      throw AppError.network();
    } catch (e) {
      throw AppError(message: 'Failed to get wallet balance');
    }
  }

  @override
  Future<WalletDto> updateWallet(Wallet wallet) {
    // TODO: implement updateWallet
    throw UnimplementedError();
  }
}
