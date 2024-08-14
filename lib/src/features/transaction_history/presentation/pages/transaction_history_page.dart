import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/bloc/transaction_list_bloc.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/widgets/transaction_list_card.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  static const String routeName = '/transactions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: BlocBuilder<TransactionListCubit, TransactionListState>(
        bloc: context.read<TransactionListCubit>()..getTransactions(),
        builder: (context, state) {
          switch (state) {
            case TransactionListInitial():
            case TransactionListLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case TransactionListSuccess():
              return ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = state.transactions[index];
                  return TransactionCard();
                },
              );
            case TransactionListFailed():
              return Center(
                child: Text(state.error),
              );
          }
        },
      ),
    );
  }
}
