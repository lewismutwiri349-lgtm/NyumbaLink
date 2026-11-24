import 'package:flutter/material.dart';

/// Colour tokens. PROVISIONAL: the palette awaits founder approval of the
/// branding (Constitution 2.1). Change values here only; never inline colours
/// in screens (Constitution 9.4).
class AppColors {
  const AppColors._();

  /// Brand primary (teal).
  static const Color primary = Color(0xFF0F766E);
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Accent (amber), reserved for the pay and unlock actions.
  static const Color accent = Color(0xFFF59E0B);
  static const Color onAccent = Color(0xFF0F172A);

  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);

  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);

  static const Color success = Color(0xFF15803D);
  static const Color error = Color(0xFFB91C1C);
}
