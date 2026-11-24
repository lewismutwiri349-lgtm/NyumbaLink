import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The single shared theme (Constitution 9.4).
///
/// Component-level styling lives in the shared widgets under core/widgets so
/// that the theme stays small and does not depend on Flutter theme classes
/// that are being renamed between Flutter releases.
class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.accent,
      onSecondary: AppColors.onAccent,
      error: AppColors.error,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
    );
  }
}
