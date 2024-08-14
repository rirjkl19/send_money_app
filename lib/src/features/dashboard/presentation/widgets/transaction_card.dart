import 'package:flutter/material.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/widgets/transaction_list_card.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transactions,
    this.isLoading = false,
    this.error,
  });

  final bool isLoading;
  final List<Transaction> transactions;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Column(
            children: [
              ListTile(
                title: const Text(
                  'Recent Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/transactions'),
                  child: const Text('View All'),
                ),
              ),
              Visibility(
                visible: !isLoading,
                replacement: const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator.adaptive(),
                ),
                child: Column(
                  children: List.generate(
                    transactions.length,
                    (index) {
                      final transaction = transactions[index];
                      return TransactionListCard(
                        sender: transaction.source.name,
                        receiver: transaction.receiver.name,
                        transactionType: transaction.type,
                        amount: transaction.amountLabel,
                        timestamp: transaction.date.toString(),
                      );
                    },
                  ),
                ),
              ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(error!),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
