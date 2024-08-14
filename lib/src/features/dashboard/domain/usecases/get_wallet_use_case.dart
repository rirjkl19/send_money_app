import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';

class GetWalletUseCase {
  final WalletRepository walletRepository;

  GetWalletUseCase(this.walletRepository);

  Future<Wallet> call() async {
    final response = await walletRepository.getWallet();
    return response.toEntity();
  }
}
