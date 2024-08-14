import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/dashboard/presentation/bloc/wallet_bloc.dart';
import 'package:money_send_app/src/features/dashboard/presentation/widgets/wallet_card.dart';
import 'package:money_send_app/src/features/send_money/presentation/pages/send_money_page.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/pages/transaction_history_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        bloc: context.read<WalletCubit>()..getWallet(),
        builder: (context, state) {
          return Stack(
            children: [
              WalletCard(
                isLoading: state.isLoading,
                error: state is WalletError ? state.message : null,
                balance: state.wallet?.balanceAsString ?? 'Loading',
                currency: state.wallet?.currency.symbol ?? '',
                onTapSendMoney: state.isLoading
                    ? null
                    : () => Navigator.of(context).pushNamed(SendMoneyPage.routeName),
                onTapViewTransactions: state.isLoading
                    ? null
                    : () => Navigator.of(context).pushNamed(TransactionHistoryPage.routeName),
              ),
            ],
          );
        },
      ),
    );
  }
}
