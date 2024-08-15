import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/dashboard/presentation/bloc/wallet_cubit.dart';
import 'package:money_send_app/src/features/dashboard/presentation/widgets/transaction_card.dart';
import 'package:money_send_app/src/features/dashboard/presentation/widgets/wallet_card.dart';
import 'package:money_send_app/src/features/send_money/presentation/pages/send_money_page.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/bloc/transaction_list_bloc.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/pages/transaction_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        children: [
          BlocBuilder<WalletCubit, WalletState>(
            bloc: context.read<WalletCubit>()..getWallet(),
            builder: (context, state) {
              return WalletCard(
                isLoading: state.isLoading,
                error: state is WalletError ? state.message : null,
                balance: state.wallet?.balanceLabel ?? 'Loading',
                onTapSendMoney: state.isLoading
                    ? null
                    : () => Navigator.of(context).pushNamed(SendMoneyPage.routeName),
                onTapViewTransactions: state.isLoading
                    ? null
                    : () => Navigator.of(context).pushNamed(TransactionsPage.routeName),
              );
            },
          ),
          BlocBuilder<TransactionListCubit, TransactionListState>(
            bloc: context.read<TransactionListCubit>()..getTransactions(),
            builder: (context, state) {
              return TransactionCard(
                isLoading: state.isLoading,
                transactions: state.transactions.take(3).toList(),
                error: state is TransactionListFailed ? state.error : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
