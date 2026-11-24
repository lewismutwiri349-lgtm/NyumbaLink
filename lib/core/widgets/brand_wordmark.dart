import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

/// Text wordmark. No logo asset exists yet; the founder supplies the logo
/// during branding approval.
class BrandWordmark extends StatelessWidget {
  const BrandWordmark({super.key, this.showParentCredit = false});

  /// Show the "A subsidiary of LGC'S GROUP" line under the name.
  final bool showParentCredit;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          AppConstants.appName,
          style: textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (showParentCredit)
          Text(
            AppConstants.parentCreditLine,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
      ],
    );
  }
}
