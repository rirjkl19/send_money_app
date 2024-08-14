import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';
import 'package:money_send_app/src/features/transaction_history/domain/usecases/get_transactions_use_case.dart';

class TransactionListCubit extends Cubit<TransactionListState> {
  TransactionListCubit({
    required this.getTransactionsUseCase,
  }) : super(const TransactionListInitial());

  @protected
  final GetTransactionsUseCase getTransactionsUseCase;

  void getTransactions() async {
    try {
      emit(const TransactionListLoading());
      final transactions = await getTransactionsUseCase();
      emit(TransactionListSuccess(transactions: transactions));
    } catch (e) {
      emit(const TransactionListFailed(error: 'Failed to get transactions'));
    }
  }
}

sealed class TransactionListState {
  const TransactionListState({this.transactions = const []});

  final List<Transaction> transactions;

  bool get isLoading => this is TransactionListLoading;
}

class TransactionListInitial extends TransactionListState {
  const TransactionListInitial();
}

class TransactionListLoading extends TransactionListState {
  const TransactionListLoading({super.transactions = const []});
}

class TransactionListSuccess extends TransactionListState {
  const TransactionListSuccess({required super.transactions});
}

class TransactionListFailed extends TransactionListState {
  const TransactionListFailed({required this.error});

  final String error;
}
