import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/brand_wordmark.dart';
import '../../../core/widgets/prototype_notice.dart';
import '../../../shared/models/user_role.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

/// First screen (FR-AUTH-01, D1): the person chooses Tenant or Landlord.
/// There is deliberately no administrator option (D14).
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _openSignUp(BuildContext context, UserRole role) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => SignUpScreen(role: role)),
    );
  }

  void _openSignIn(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Center(child: BrandWordmark(showParentCredit: true)),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  AppConstants.marketDescriptor,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'How will you use ${AppConstants.appName}?',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                _RoleCard(
                  icon: Icons.search_rounded,
                  title: UserRole.tenant.label,
                  subtitle: 'I am looking for a place to rent',
                  onTap: () => _openSignUp(context, UserRole.tenant),
                ),
                const SizedBox(height: AppSpacing.sm),
                _RoleCard(
                  icon: Icons.home_work_outlined,
                  title: UserRole.landlord.label,
                  subtitle: 'I want to advertise my property',
                  onTap: () => _openSignUp(context, UserRole.landlord),
                ),
                const SizedBox(height: AppSpacing.md),
                TextButton(
                  onPressed: () => _openSignIn(context),
                  child: const Text('Already have an account? Sign in'),
                ),
                const PrototypeNotice(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 32, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: textTheme.titleMedium),
                    Text(
                      subtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
