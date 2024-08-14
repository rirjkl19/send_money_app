import 'package:flutter/material.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction_type.dart';

class TransactionListCard extends StatelessWidget {
  const TransactionListCard({
    super.key,
    required this.sender,
    required this.receiver,
    required this.transactionType,
    required this.amount,
    required this.timestamp,
  });

  final String receiver;
  final String sender;
  final TransactionType transactionType;
  final String amount;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            transactionType.transactionLabel,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(timestamp, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(receiver, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            transactionType == TransactionType.deposit ? '+ $amount' : '- $amount',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transactionType == TransactionType.deposit ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
