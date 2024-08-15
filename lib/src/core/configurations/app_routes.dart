import 'package:flutter/material.dart';
import 'package:money_send_app/src/core/pages/invalid_page.dart';
import 'package:money_send_app/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:money_send_app/src/features/send_money/presentation/pages/send_money_page.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/pages/transaction_page.dart';

final class AppRoutes {
  const AppRoutes._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final Object? args = settings.arguments;
    switch (settings.name) {
      case DashboardPage.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => const DashboardPage());
      case SendMoneyPage.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => const SendMoneyPage());
      case TransactionsPage.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => const TransactionsPage());
      default:
        return MaterialPageRoute(settings: settings, builder: (_) => const InvalidPage());
    }
  }
}
