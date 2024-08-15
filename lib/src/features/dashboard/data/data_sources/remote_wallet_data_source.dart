import 'dart:math';

import 'package:money_send_app/src/core/configurations/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';

class RemoteWalletDataSource {
  Future<http.Response> getWallet(String walletId) async {
    final url = Uri.http(AppConstants.baseUrl, '/wallets/$walletId');

    // ! Simulate network delay
    await Future.delayed(Duration(seconds: Random().nextInt(2)));

    return await http.get(url);
  }

  Future<http.Response> updateWallet(WalletDto wallet) async {
    final url = Uri.http(AppConstants.baseUrl, '/wallets/${wallet.id}');

    // ! Simulate network delay
    await Future.delayed(Duration(seconds: Random().nextInt(2)));

    return await http.put(url, body: wallet.toJson());
  }
}
