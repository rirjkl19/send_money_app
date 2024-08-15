import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:money_send_app/src/core/configurations/app_constants.dart';
import 'package:http/http.dart' as http;

class WalletDataSource {
  Future<Response> getWallet() async {
    final url = Uri.http(AppConstants.baseUrl, '/wallet');

    // ! Simulate network delay
    await Future.delayed(Duration(seconds: Random().nextInt(2)));

    return await http.get(url);
  }

  Future<Response> mockSendMoney({required double amount, required String accountNumber}) async {
    // ! Simulate only sending money to account number '123456789'
    if (accountNumber == '123456789') {
      final url = Uri.http(AppConstants.baseUrl, '/send-money');

      // ! Simulate network delay
      await Future.delayed(Duration(seconds: Random().nextInt(2)));

      return await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'amount': amount, 'accountNumber': accountNumber}),
      );
    } else {
      throw Exception('Failed to send money');
    }
  }
}
