import 'package:flutter_test/flutter_test.dart';
import 'package:nyumbalink/core/utils/validators.dart';

void main() {
  group('validateEmail', () {
    test('accepts a plausible address', () {
      expect(validateEmail('name@example.com'), isNull);
      expect(validateEmail('  name@example.co.ke  '), isNull);
    });

    test('rejects empty and malformed input', () {
      expect(validateEmail(null), isNotNull);
      expect(validateEmail(''), isNotNull);
      expect(validateEmail('name'), isNotNull);
      expect(validateEmail('name@example'), isNotNull);
      expect(validateEmail('na me@example.com'), isNotNull);
    });
  });

  group('validateKenyanPhone', () {
    test('accepts valid Kenyan numbers', () {
      expect(validateKenyanPhone('0712 345 678'), isNull);
      expect(validateKenyanPhone('+254112345678'), isNull);
    });

    test('rejects empty and invalid numbers', () {
      expect(validateKenyanPhone(null), isNotNull);
      expect(validateKenyanPhone(''), isNotNull);
      expect(validateKenyanPhone('12345'), isNotNull);
    });
  });
}
