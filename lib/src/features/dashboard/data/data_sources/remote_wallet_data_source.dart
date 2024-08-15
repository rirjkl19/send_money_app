import 'package:money_send_app/src/core/configurations/app_constants.dart';
import 'package:http/http.dart' as http;

class RemoteWalletDataSource {
  Future<http.Response> getWallet(String walletId) async {
    final url = Uri.http(AppConstants.baseUrl, '/wallet', ({'id': walletId}));
    return await http.get(url);
  }
}
