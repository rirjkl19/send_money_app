import 'dart:io';

import 'package:http/http.dart';
import 'package:money_send_app/src/core/configurations/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:money_send_app/src/core/configurations/app_error.dart';

final class RemoteDataSource {
  Future<Response> getWallet() async {
    try {
      final url = Uri.http(AppConstants.baseUrl, '/wallet');
      return await http.get(url);
    } on SocketException {
      throw AppError.network();
    } catch (e) {
      throw AppError(message: 'Failed to get wallet balance');
    }
  }
}
