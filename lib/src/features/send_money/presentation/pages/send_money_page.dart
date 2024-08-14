import 'package:flutter/material.dart';
import 'package:money_send_app/src/features/send_money/presentation/widgets/money_input_field.dart';
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

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      setState(() {}); // Rebuilds the widget when the amount changes
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
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
          onChanged: _formKey.currentState?.validate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoneyInputField(
                controller: _amountController,
                prefix: const Text('₱ '),
              ),
              SendMoneyButton(
                isButtonEnabled: _formKey.currentState?.validate() ?? false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
