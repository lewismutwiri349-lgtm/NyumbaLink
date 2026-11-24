/// Formats a whole-shilling amount, for example `3500` -> `KES 3,500`.
///
/// The prototype stores rent in whole shillings. The production database
/// uses an exact numeric type (NFR-DATA-01).
String formatKes(int amount) {
  final String digits = amount.abs().toString();
  final StringBuffer grouped = StringBuffer();
  for (int index = 0; index < digits.length; index++) {
    grouped.write(digits[index]);
    final int remaining = digits.length - index;
    if (remaining > 1 && remaining % 3 == 1) {
      grouped.write(',');
    }
  }
  final String sign = amount < 0 ? '-' : '';
  return '${sign}KES $grouped';
}

/// Converts a Kenyan mobile number to the international form `+254XXXXXXXXX`.
///
/// Accepts `0712345678`, `0112345678`, `712345678`, `254712345678` and
/// `+254712345678`, with spaces, dashes or brackets. Returns `null` when the
/// input is not a Kenyan mobile number in one of these forms.
String? normaliseKenyanPhone(String input) {
  final String cleaned = input.replaceAll(RegExp(r'[\s\-()]'), '');
  final RegExpMatch? match =
      RegExp(r'^(?:\+?254|0)?([71]\d{8})$').firstMatch(cleaned);
  if (match == null) {
    return null;
  }
  return '+254${match.group(1)}';
}
