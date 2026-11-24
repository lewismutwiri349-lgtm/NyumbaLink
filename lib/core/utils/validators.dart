import 'formatters.dart';

/// Form validators. Each returns an error message for the user, or `null`
/// when the value is acceptable. Messages are plain English (D6) and expose
/// no technical detail (Constitution 10.3).
///
/// These checks only catch typing mistakes. Email ownership is proven by the
/// verification email, and phone ownership by the M-PESA prompt (FR-AUTH-03).
String? validateEmail(String? value) {
  final String email = (value ?? '').trim();
  if (email.isEmpty) {
    return 'Enter your email address.';
  }
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
    return 'Enter a valid email address.';
  }
  return null;
}

String? validateKenyanPhone(String? value) {
  final String phone = (value ?? '').trim();
  if (phone.isEmpty) {
    return 'Enter your phone number.';
  }
  if (normaliseKenyanPhone(phone) == null) {
    return 'Enter a valid Kenyan phone number, for example 07XX XXX XXX.';
  }
  return null;
}
