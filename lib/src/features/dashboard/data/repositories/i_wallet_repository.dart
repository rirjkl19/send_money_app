import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/remote_wallet_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';

interface class IWalletRepository implements WalletRepository {
  const IWalletRepository({required this.walletDataSource});

  @protected
  final RemoteWalletDataSource walletDataSource;

  @override
  Future<WalletDto> getWallet(String walletId) async {
    try {
      final response = await walletDataSource.getWallet(walletId);
      return WalletDto.fromJson(response.body);
    } on SocketException {
      throw AppError.network();
    } catch (e) {
      throw AppError(message: 'Failed to get wallet balance');
    }
  }

  @override
  Future<WalletDto> updateWallet(WalletDto wallet) async {
    try {
      final response = await walletDataSource.updateWallet(wallet);
      return WalletDto.fromJson(response.body);
    } on SocketException {
      throw AppError.network();
    } catch (e) {
      throw AppError(message: 'Failed to update wallet balance');
    }
  }
}
