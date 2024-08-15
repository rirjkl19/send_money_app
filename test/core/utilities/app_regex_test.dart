import 'package:flutter_test/flutter_test.dart';
import 'package:money_send_app/src/core/utilities/app_regex.dart';

void main() {
  group('AppRegex', () {
    group('amountInput', () {
      test('should return true when the input is a valid amount', () {
        const input = '1000';
        final result = AppRegex.amountInput.hasMatch(input);
        expect(result, true);
      });
      test('should return true when the input has 1 decimal place', () {
        const input = '1000.0';
        final result = AppRegex.amountInput.hasMatch(input);
        expect(result, true);
      });

      test('should return true when the input has 2 decimal places', () {
        const input = '1000.00';
        final result = AppRegex.amountInput.hasMatch(input);
        expect(result, true);
      });

      test('should return true when the input has more than 2 decimal places', () {
        const input = '1000.0000000';
        final result = AppRegex.amountInput.hasMatch(input);
        expect(result, true);
      });
    });
  });
}
