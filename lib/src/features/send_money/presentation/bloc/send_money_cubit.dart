import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/send_money/domain/entities/send_money_args.dart';
import 'package:money_send_app/src/features/send_money/domain/usecases/send_money_use_case.dart';
import 'package:money_send_app/src/features/transaction_history/domain/entities/transaction.dart';

class SendMoneyCubit extends Cubit<SendMoneyState> {
  SendMoneyCubit(this._sendMoneyUseCase) : super(SendMoneyInitial());

  final SendMoneyUseCase _sendMoneyUseCase;

  void sendMoney({
    required Currency currency,
    required String amountInput,
    required String accountNumber,
  }) async {
    try {
      emit(SendMoneyLoading());
      final amount = double.tryParse(amountInput);
      if (amount == null) {
        emit(SendMoneyFailure('Invalid amount'));
        return;
      }
      final transactionResponse = await _sendMoneyUseCase(
        SendMoneyArgs(
          accountNumber: accountNumber,
          amount: amount,
          currency: currency,
        ),
      );
      emit(SendMoneySuccess(transaction: transactionResponse));
    } on AppError catch (e) {
      emit(SendMoneyFailure(e.message));
    } catch (e) {
      emit(SendMoneyFailure(e.toString()));
    }
  }
}

sealed class SendMoneyState {
  bool get isLoading => this is SendMoneyLoading;
}

class SendMoneyInitial extends SendMoneyState {}

class SendMoneyLoading extends SendMoneyState {}

class SendMoneySuccess extends SendMoneyState {
  final Transaction transaction;

  SendMoneySuccess({required this.transaction});
}

class SendMoneyFailure extends SendMoneyState {
  final String message;

  SendMoneyFailure(this.message);
}
