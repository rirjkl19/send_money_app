import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/presentation/bloc/wallet_cubit.dart';
import 'package:money_send_app/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:money_send_app/src/features/send_money/domain/usecases/send_money_use_case.dart';
import 'package:money_send_app/src/features/send_money/presentation/bloc/send_money_bloc.dart';
import 'package:money_send_app/src/features/send_money/presentation/dialogs/send_transaction_failed_dialog.dart';
import 'package:money_send_app/src/features/send_money/presentation/dialogs/send_transaction_success_dialog.dart';
import 'package:money_send_app/src/features/send_money/presentation/widgets/money_input_field.dart';
import 'package:money_send_app/src/features/send_money/presentation/widgets/recipient_input_field.dart';
import 'package:money_send_app/src/features/send_money/presentation/widgets/send_money_button.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  static const String routeName = '/send-money';

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _currency = Currency.php;
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _formValid = ValueNotifier(false);

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    _formValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendMoneyCubit>(
      create: (context) {
        final repository = RepositoryProvider.of<WalletRepository>(context);
        final sendMoneyUseCase = SendMoneyUseCase(repository);
        return SendMoneyCubit(sendMoneyUseCase);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Send Money')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: BlocConsumer<SendMoneyCubit, SendMoneyState>(
            listener: (context, state) {
              switch (state) {
                case SendMoneySuccess():
                  SendTransactionSuccessDialog(
                    accountNumber: state.transaction.receiver.name,
                    amountSent: state.transaction.amountLabel,
                    onDone: () {
                      Navigator.of(context).popUntil(ModalRoute.withName(DashboardPage.routeName));
                    },
                  ).showAsModalBottomSheet(context, isDismissible: false);
                  break;
                case SendMoneyFailure():
                  SendTransactionFailedDialog(
                    accountNumber: _recipientController.text,
                    amountSent: _amountController.text,
                    onDone: Navigator.of(context).pop,
                  ).showAsModalBottomSheet(context, isDismissible: false);
                default:
              }
            },
            builder: (context, sendState) {
              return Form(
                key: _formKey,
                onChanged: () {
                  _formValid.value = _formKey.currentState?.validate() ?? false;
                },
                child: Column(
                  children: [
                    AccountNumberInputField(
                      controller: _recipientController,
                      enabled: !sendState.isLoading,
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<WalletCubit, WalletState>(
                      builder: (context, walletState) {
                        return MoneyInputField(
                          enabled: !sendState.isLoading,
                          controller: _amountController,
                          prefix: Text('${_currency.symbol} '),
                          wallet: walletState.wallet,
                        );
                      },
                    ),
                    const Spacer(),
                    ListenableBuilder(
                      listenable: _formValid,
                      builder: (context, _) => SendMoneyButton(
                        isButtonEnabled: _formValid.value && !sendState.isLoading,
                        isLoading: sendState.isLoading,
                        onPressed: () {
                          context.read<SendMoneyCubit>().sendMoney(
                              amountInput: _amountController.text,
                              accountNumber: _recipientController.text,
                              currency: _currency);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
