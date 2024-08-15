import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:money_send_app/src/core/configurations/app_constants.dart';
import 'package:money_send_app/src/features/transaction_history/data/dto/transaction_dto.dart';

class TransactionDataSource {
  Future<Response> getTransactions() async {
    final url = Uri.http(AppConstants.baseUrl, '/transactions');

    // ! Simulate network delay
    await Future.delayed(Duration(seconds: Random().nextInt(2)));

    return await http.get(url);
  }

  Future<Response> sendMoney(TransactionDto transaction) async {
    final url = Uri.http(AppConstants.baseUrl, '/send-money');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: transaction.toJson(),
    );
  }
}
