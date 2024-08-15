import 'package:flutter/material.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';
import 'package:money_send_app/src/features/send_money/domain/entities/send_money_args.dart';
import 'package:money_send_app/src/features/transaction_history/data/dto/transaction_dto.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';

class SendMoneyUseCase {
  const SendMoneyUseCase({
    required this.transactionRepository,
    required this.userRepository,
  });

  @protected
  final TransactionRepository transactionRepository;

  @protected
  final UserRepository userRepository;

  /// Sends money to the recipient.
  Future<Transaction> call(SendMoneyArgs params) async {
    final currentUser = await userRepository.getCurrentUser();
    final user = await userRepository.getUser(params.accountNumber);
    final transaction = await transactionRepository.sendMoney(
      TransactionDto(
        id: params.hashCode.toString(),
        type: TransactionType.deposit,
        source: currentUser,
        receiver: user,
        amount: params.amount,
        currency: params.currency,
        date: DateTime.now(),
      ),
    );
    return transaction.toEntity();
  }
}
