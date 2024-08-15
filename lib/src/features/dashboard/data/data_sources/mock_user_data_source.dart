import 'package:http/http.dart' as http;

class MockUserDataSource {
  /// Mock implementation of the getUser method. Should have been coming from an in-memory/cache db.
  /// Or actual auth token
  Future<http.Response> getCurrentUser() async {
    return http.Response('''{
            "id": "123",
            "walletId": "54a6cbaa-e0a2-4e08-81e5-1b66df0e81e1",
            "name": "John Doe"
        }''', 200);
  }
}
