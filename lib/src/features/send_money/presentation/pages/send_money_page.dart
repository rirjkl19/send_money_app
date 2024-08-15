import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/dashboard/presentation/bloc/wallet_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _formValid = ValueNotifier(false);

  @override
  void dispose() {
    _amountController.dispose();
    _formValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: _formKey,
          onChanged: () {
            _formValid.value = _formKey.currentState?.validate() ?? false;
          },
          child: Column(
            children: [
              const AccountNumberInputField(),
              const SizedBox(height: 12),
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  return MoneyInputField(
                    controller: _amountController,
                    prefix: const Text('₱ '),
                    wallet: state.wallet,
                  );
                },
              ),
              const Spacer(),
              ListenableBuilder(
                listenable: _formValid,
                builder: (context, _) {
                  return SendMoneyButton(isButtonEnabled: _formValid.value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
