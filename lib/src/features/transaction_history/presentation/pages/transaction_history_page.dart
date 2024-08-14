import 'package:flutter/material.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/widgets/transaction_list_card.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  static const String routeName = '/transaction-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return TransactionCard();
        },
      ),
    );
  }
}
