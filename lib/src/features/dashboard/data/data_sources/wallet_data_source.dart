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
}
