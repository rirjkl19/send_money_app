import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<List<Transaction>> getTransactions();
}
