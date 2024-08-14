import 'package:flutter/material.dart';
import 'package:money_send_app/src/core/generic_pages/invalid_page.dart';
import 'package:money_send_app/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:money_send_app/src/features/send_money/presentation/pages/send_money_page.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/pages/transaction_history_page.dart';

final class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final Object? args = settings.arguments;
    switch (settings.name) {
      case DashboardPage.routeName:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case SendMoneyPage.routeName:
        return MaterialPageRoute(builder: (_) => const SendMoneyPage());
      case TransactionHistoryPage.routeName:
        return MaterialPageRoute(builder: (_) => const TransactionHistoryPage());
      default:
        return MaterialPageRoute(builder: (_) => const InvalidPage());
    }
  }
}
