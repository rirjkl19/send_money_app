import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';

abstract interface class WalletRepository {
  Future<WalletDto> getWallet(String walletId);
}
