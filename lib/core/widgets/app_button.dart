import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum AppButtonVariant {
  /// Main action on a screen.
  primary,

  /// Pay and unlock actions only.
  accent,

  /// Secondary action.
  outlined,
}

/// Shared button. Shows a spinner and ignores taps while [isLoading].
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnPressed = isLoading ? null : onPressed;
    const Size minimumSize = Size.fromHeight(AppSpacing.minTouchTarget);

    final Color spinnerColor = switch (variant) {
      AppButtonVariant.primary => AppColors.onPrimary,
      AppButtonVariant.accent => AppColors.onAccent,
      AppButtonVariant.outlined => AppColors.primary,
    };

    final Widget content = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: spinnerColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 20),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(child: Text(label, textAlign: TextAlign.center)),
            ],
          );

    return switch (variant) {
      AppButtonVariant.primary => FilledButton(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(minimumSize: minimumSize),
          child: content,
        ),
      AppButtonVariant.accent => FilledButton(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(
            minimumSize: minimumSize,
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.onAccent,
          ),
          child: content,
        ),
      AppButtonVariant.outlined => OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(minimumSize: minimumSize),
          child: content,
        ),
    };
  }
}
