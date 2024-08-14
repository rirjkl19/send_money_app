import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Transaction', style: TextStyle(color: Colors.grey, fontSize: 12)),
          Text('Today', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Transaction details', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('₱ 100.00', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
