import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/prototype_notice.dart';
import '../../../features/prototype/role_home_placeholder_screen.dart';
import '../../../shared/models/user_role.dart';

/// Shown after sign-up. Listings and payments stay locked until the email is
/// verified (SYSTEM_ARCHITECTURE s.5). The phone number is not verified by an
/// SMS code (FR-AUTH-03).
class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.role,
  });

  final String email;
  final UserRole role;

  void _continue(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => RoleHomePlaceholderScreen(role: role),
      ),
      (Route<dynamic> route) => route.isFirst,
    );
  }

  void _resend(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prototype: no email is sent.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Verify your email')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(
                Icons.mark_email_unread_outlined,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Verify your email',
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'We sent a verification link to $email. '
                'Open it, then come back here.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: 'I have verified my email',
                onPressed: () => _continue(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: 'Resend email',
                variant: AppButtonVariant.outlined,
                onPressed: () => _resend(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Use a different email'),
              ),
              const PrototypeNotice(),
            ],
          ),
        ),
      ),
    );
  }
}
