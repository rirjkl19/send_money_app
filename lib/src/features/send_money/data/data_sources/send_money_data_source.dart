import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:money_send_app/src/core/configurations/app_constants.dart';

class SendMoneyDataSource {
  Future<Response> sendMoney({required double amount, required String accountNumber}) async {
    final url = Uri.http(AppConstants.baseUrl, '/send-money');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'amount': amount, 'accountNumber': accountNumber}),
    );
  }
}
