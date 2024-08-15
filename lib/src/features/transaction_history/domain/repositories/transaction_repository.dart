import 'package:money_send_app/src/features/transaction_history/data/dto/transaction_dto.dart';

abstract interface class TransactionRepository {
  Future<List<TransactionDto>> getTransactions();
  Future<TransactionDto> sendMoney(TransactionDto transactionDto);
}
