import 'package:http/http.dart';
import 'package:money_send_app/src/core/configurations/app_constants.dart';
import 'package:http/http.dart' as http;

class WalletDataSource {
  Future<Response> getWallet() async {
    final url = Uri.http(AppConstants.baseUrl, '/wallet');
    return await http.get(url);
  }
}
