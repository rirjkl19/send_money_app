import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/wallet_dto.dart';

void main() {
  const walletStub = WalletDto(id: '1', balance: 100, currency: 'USD');
  const walletMapStub = {'id': '1', 'balance': 100.0, 'currency': 'USD'};

  group('WalletDto', () {
    test('toMap should return a correct map', () {
      final result = walletStub.toMap();
      expect(result, walletMapStub);
    });

    test('fromMap should return a correct WalletDto instance', () {
      final result = WalletDto.fromMap(walletMapStub);
      expect(result.id, '1');
      expect(result.balance, 100.0);
      expect(result.currency, 'USD');
    });

    test('toJson should return a correct JSON string', () {
      const json = '{"id":"1","balance":100.0,"currency":"USD"}';
      final result = walletStub.toJson();
      expect(result, json);
    });

    test('fromJson should return a correct WalletDto instance', () {
      const json = '{"id":"1","balance":100.0,"currency":"USD"}';
      final result = WalletDto.fromJson(json);
      expect(result.balance, 100.0);
      expect(result.currency, 'USD');
    });

    test('toEntity should correctly convert to Wallet entity', () {
      final entity = walletStub.toEntity();
      expect(entity.balance, walletStub.balance);
      expect(entity.currency.toDtoName, walletStub.currency);
    });
  });
}
