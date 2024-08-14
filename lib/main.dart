import 'package:flutter/material.dart';
import 'package:money_send_app/src/core/configurations/app_bloc_wrapper.dart';
import 'package:money_send_app/src/core/configurations/app_routes.dart';

void main() {
  runApp(const MoneySendApp());
}

class MoneySendApp extends StatelessWidget {
  const MoneySendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBlocWrapper(
      child: MaterialApp(
        title: 'Money Send App',
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
