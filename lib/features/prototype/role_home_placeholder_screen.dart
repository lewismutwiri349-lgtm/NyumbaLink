import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/state_views.dart';
import '../../shared/models/user_role.dart';

/// TEMPORARY destination after sign-in or sign-up. Replaced by the tenant
/// home in step 1C and the landlord dashboard in step 1D.
class RoleHomePlaceholderScreen extends StatelessWidget {
  const RoleHomePlaceholderScreen({super.key, this.role});

  /// Null after sign-in: in the real app the role comes from the account.
  final UserRole? role;

  String get _message => switch (role) {
        UserRole.tenant => 'The tenant home screen is built in step 1C.',
        UserRole.landlord => 'The landlord dashboard is built in step 1D.',
        null => 'Your home screen depends on your account type. '
            'It is built in steps 1C and 1D.',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(role?.label ?? 'Home'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: EmptyStateView(
                icon: Icons.construction_rounded,
                title: 'You are signed in',
                message: _message,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: AppButton(
                label: 'Sign out',
                variant: AppButtonVariant.outlined,
                onPressed: () => Navigator.of(context)
                    .popUntil((Route<dynamic> route) => route.isFirst),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
