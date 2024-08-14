import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:money_send_app/src/core/configurations/app_constants.dart';

class TransactionDataSource {
  Future<Response> getTransactions() async {
    final url = Uri.http(AppConstants.baseUrl, '/transactions');

    // ! Simulate network delay
    await Future.delayed(Duration(seconds: Random().nextInt(2)));

    return await http.get(url);
  }
}
