import 'package:flutter/material.dart';

class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({super.key});

  static const String routeName = '/send-money';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
      ),
      body: const Center(
        child: Text('Send Money Page'),
      ),
    );
  }
}
