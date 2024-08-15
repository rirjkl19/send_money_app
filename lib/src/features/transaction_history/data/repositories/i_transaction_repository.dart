import 'package:flutter/foundation.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/features/transaction_history/data/data_sources/transaction_data_source.dart';
import 'package:money_send_app/src/features/transaction_history/data/dto/transaction_dto.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';

interface class ITransactionRepository implements TransactionRepository {
  const ITransactionRepository({required this.transactionDataSource});

  @protected
  final TransactionDataSource transactionDataSource;

  @override
  Future<List<TransactionDto>> getTransactions() async {
    try {
      final response = await transactionDataSource.getTransactions();
      return TransactionDto.fromJsonList(response.body);
    } catch (e) {
      throw AppError(message: 'Failed to get transactions');
    }
  }

  @override
  Future<TransactionDto> sendMoney(TransactionDto transaction) async {
    try {
      final response = await transactionDataSource.sendMoney(transaction);
      return TransactionDto.fromJson(response.body);
    } catch (e) {
      throw AppError(message: 'Failed to send money');
    }
  }
}
