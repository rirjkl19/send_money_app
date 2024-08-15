import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';
import 'package:money_send_app/src/features/send_money/domain/entities/send_money_args.dart';

abstract interface class WalletRepository {
  Future<WalletDto> getWallet();
  Future<bool> mockSendMoney(SendMoneyArgs params);
}
