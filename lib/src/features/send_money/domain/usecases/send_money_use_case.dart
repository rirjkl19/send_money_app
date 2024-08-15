import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:money_send_app/src/features/send_money/domain/entities/send_money_args.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

class SendMoneyUseCase {
  final WalletRepository _walletRepository;

  SendMoneyUseCase(this._walletRepository);

  /// Sends money to the recipient.
  ///
  /// Will return a mocked transaction response
  Future<Transaction> mockSendMoney(SendMoneyArgs params) async {
    await _walletRepository.mockSendMoney(params);
    return Transaction(
      id: '1',
      type: TransactionType.deposit,
      currency: params.currency,
      amount: params.amount,
      source: const User(id: '1', name: 'user'),
      receiver: User(id: '2', name: params.accountNumber),
      date: DateTime.now(),
    );
  }
}
