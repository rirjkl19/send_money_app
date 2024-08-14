import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';

void main() {
  const goldenStub = WalletDto(balance: 100.0, currency: 'USD');

  group('WalletDto', () {
    test('toMap should return a correct map', () {
      final expectedMap = {'balance': 100.0, 'currency': 'USD'};
      final result = goldenStub.toMap();
      expect(result, expectedMap);
    });

    test('fromMap should return a correct WalletDto instance', () {
      final map = {'balance': 100.0, 'currency': 'USD'};
      final result = WalletDto.fromMap(map);
      expect(result.balance, 100.0);
      expect(result.currency, 'USD');
    });

    test('toJson should return a correct JSON string', () {
      const json = '{"balance":100.0,"currency":"USD"}';
      final result = goldenStub.toJson();
      expect(result, json);
    });

    test('fromJson should return a correct WalletDto instance', () {
      const json = '{"balance":100.0,"currency":"USD"}';
      final result = WalletDto.fromJson(json);
      expect(result.balance, 100.0);
      expect(result.currency, 'USD');
    });

    test('toEntity should correctly convert to Wallet entity', () {
      final entity = goldenStub.toEntity();
      expect(entity.balance, goldenStub.balance);
      expect(entity.currency, goldenStub.currency);
    });
  });
}
