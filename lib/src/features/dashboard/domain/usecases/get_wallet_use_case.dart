import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';

class GetWalletUseCase {
  const GetWalletUseCase({
    required this.walletRepository,
    required this.userRepository,
  });

  final WalletRepository walletRepository;
  final UserRepository userRepository;

  Future<Wallet> call() async {
    final currentUser = await userRepository.getCurrentUser();
    final response = await walletRepository.getWallet(currentUser.walletId);
    return response.toEntity();
  }
}
