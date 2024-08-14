import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
    required this.balance,
    required this.currency,
    required this.onTapSendMoney,
    required this.onTapViewTransactions,
  });

  final String balance;
  final String currency;

  final VoidCallback onTapSendMoney;
  final VoidCallback onTapViewTransactions;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '₱500.00',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.remove_red_eye),
              ],
            ),
            Text('Available Balance', style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: onTapSendMoney,
                    child: const Text(
                      'Send Money',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: onTapViewTransactions,
                    child: const Text(
                      'View Transactions',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
