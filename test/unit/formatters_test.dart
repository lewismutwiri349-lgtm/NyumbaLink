import 'package:flutter_test/flutter_test.dart';
import 'package:nyumbalink/core/utils/formatters.dart';

void main() {
  group('formatKes', () {
    test('formats amounts with thousands separators', () {
      expect(formatKes(0), 'KES 0');
      expect(formatKes(200), 'KES 200');
      expect(formatKes(3500), 'KES 3,500');
      expect(formatKes(1234567), 'KES 1,234,567');
    });

    test('formats negative amounts with a leading minus', () {
      expect(formatKes(-3500), '-KES 3,500');
    });
  });

  group('normaliseKenyanPhone', () {
    test('accepts the common local and international forms', () {
      expect(normaliseKenyanPhone('0712345678'), '+254712345678');
      expect(normaliseKenyanPhone('0112345678'), '+254112345678');
      expect(normaliseKenyanPhone('712345678'), '+254712345678');
      expect(normaliseKenyanPhone('254712345678'), '+254712345678');
      expect(normaliseKenyanPhone('+254712345678'), '+254712345678');
    });

    test('ignores spaces, dashes and brackets', () {
      expect(normaliseKenyanPhone('0712 345 678'), '+254712345678');
      expect(normaliseKenyanPhone('+254 (712) 345-678'), '+254712345678');
    });

    test('rejects numbers that are not Kenyan mobile numbers', () {
      expect(normaliseKenyanPhone(''), isNull);
      expect(normaliseKenyanPhone('071234567'), isNull);
      expect(normaliseKenyanPhone('07123456789'), isNull);
      expect(normaliseKenyanPhone('0212345678'), isNull);
      expect(normaliseKenyanPhone('abcdefghij'), isNull);
      expect(normaliseKenyanPhone('+255712345678'), isNull);
    });
  });
}
