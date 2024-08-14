import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';

abstract interface class WalletRepository {
  Future<WalletDto> getWallet();
  Future<WalletDto> updateWallet(Wallet wallet);
}
