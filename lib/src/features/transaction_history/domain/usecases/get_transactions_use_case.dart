import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<Transaction>> call() async {
    final transactions = await repository.getTransactions();
    return transactions.map((transaction) => transaction.toEntity()).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
}
