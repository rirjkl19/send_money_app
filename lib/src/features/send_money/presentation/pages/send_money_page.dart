import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/currency.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/presentation/bloc/wallet_cubit.dart';
import 'package:money_send_app/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:money_send_app/src/features/send_money/domain/usecases/get_current_user_use_case.dart';
import 'package:money_send_app/src/features/send_money/domain/usecases/send_money_use_case.dart';
import 'package:money_send_app/src/features/send_money/presentation/bloc/get_current_user_cubit.dart';
import 'package:money_send_app/src/features/send_money/presentation/bloc/send_money_cubit.dart';
import 'package:money_send_app/src/features/send_money/presentation/dialogs/send_transaction_failed_dialog.dart';
import 'package:money_send_app/src/features/send_money/presentation/dialogs/send_transaction_success_dialog.dart';
import 'package:money_send_app/src/features/send_money/presentation/widgets/money_input_field.dart';
import 'package:money_send_app/src/features/send_money/presentation/widgets/recipient_input_field.dart';
import 'package:money_send_app/src/features/send_money/presentation/widgets/send_money_button.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/bloc/transaction_list_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<SendMoneyCubit>(
          create: (context) {
            final sendMoneyUseCase = SendMoneyUseCase(
              walletRepository: context.read<WalletRepository>(),
              userRepository: context.read<UserRepository>(),
              transactionRepository: context.read<TransactionRepository>(),
            );
            return SendMoneyCubit(sendMoneyUseCase);
          },
        ),
        BlocProvider(
          create: (context) => GetCurrentUserCubit(
            GetCurrentUserUseCase(context.read<UserRepository>()),
          )..getCurrentUser(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Send Money')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: BlocConsumer<SendMoneyCubit, SendMoneyState>(
            listener: (context, state) {
              switch (state) {
                case SendMoneySuccess():
                  context.read<WalletCubit>().getWallet();
                  context.read<TransactionListCubit>().getTransactions();
                  SendTransactionSuccessDialog(
                    accountNumber: state.transaction.receiver.name,
                    amountSent: state.transaction.amountLabel,
                    onDone: () {
                      Navigator.of(context).popUntil(ModalRoute.withName(DashboardPage.routeName));
                    },
                  ).showAsModalBottomSheet(context, isDismissible: false);
                  break;
                case SendMoneyFailure():
                  context.read<WalletCubit>().getWallet();
                  SendTransactionFailedDialog(
                    accountNumber: _recipientController.text,
                    amountSent: _amountController.text,
                    onDone: Navigator.of(context).pop,
                  ).showAsModalBottomSheet(context, isDismissible: false);
                  break;
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
                    BlocBuilder<GetCurrentUserCubit, User?>(
                      builder: (context, userState) {
                        return AccountNumberInputField(
                          currentUserId: userState?.id,
                          controller: _recipientController,
                          enabled: !sendState.isLoading && userState != null,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<WalletCubit, WalletState>(
                      builder: (context, walletState) {
                        return MoneyInputField(
                          enabled: !sendState.isLoading,
                          controller: _amountController,
                          prefix: Text('//${_currency.symbol} '),
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
