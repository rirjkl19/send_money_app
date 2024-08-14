import 'dart:ui';

import 'package:flutter/material.dart';

class WalletCard extends StatefulWidget {
  const WalletCard({
    super.key,
    required this.balance,
    required this.currency,
    required this.onTapSendMoney,
    required this.onTapViewTransactions,
    this.error,
    this.isLoading = false,
  });

  final String balance;
  final String currency;

  final VoidCallback? onTapSendMoney;
  final VoidCallback? onTapViewTransactions;
  final String? error;
  final bool isLoading;

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  bool get _hasError => widget.error != null;
  final _showBalance = ValueNotifier(true);

  @override
  void dispose() {
    _showBalance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListenableBuilder(
                  listenable: _showBalance,
                  builder: (context, value) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _showBalance.value || widget.isLoading
                                ? '${widget.currency}${widget.balance}'
                                : '${widget.currency}********',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headlineLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: widget.isLoading
                              ? null
                              : () => _showBalance.value = !_showBalance.value,
                          icon: _showBalance.value
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ],
                    );
                  },
                ),
                Text('Available Balance', style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: widget.onTapSendMoney,
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
                        onPressed: widget.onTapViewTransactions,
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
          if (_hasError)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white60,
                  child: Text(widget.error ?? '', textAlign: TextAlign.center),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
