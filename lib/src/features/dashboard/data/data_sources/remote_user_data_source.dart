import 'package:money_send_app/src/core/configurations/app_constants.dart';
import 'package:http/http.dart' as http;

class RemoteUserDataSource {
  Future<http.Response> getUser(String walletId) async {
    final url = Uri.http(AppConstants.baseUrl, '/users/$walletId');
    return await http.get(url);
  }

  Future<http.Response> getUsers() async {
    final url = Uri.http(AppConstants.baseUrl, '/users');
    return await http.get(url);
  }
}
