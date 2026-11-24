import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/brand_wordmark.dart';
import '../../core/widgets/state_views.dart';
import '../../shared/data/sample_fee_schedule.dart';
import '../../shared/data/sample_listings.dart';

/// TEMPORARY Phase 1 step 1A screen that shows the shared design system so the
/// founder can review branding. Replaced by the welcome screen in step 1B.
class DesignGalleryScreen extends StatelessWidget {
  const DesignGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design gallery (prototype)')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: <Widget>[
          const Center(child: BrandWordmark(showParentCredit: true)),
          const _SectionTitle('Buttons'),
          AppButton(label: 'Continue', onPressed: () {}),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Pay to view contact',
            icon: Icons.lock_open_rounded,
            variant: AppButtonVariant.accent,
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Cancel',
            variant: AppButtonVariant.outlined,
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(label: 'Working', onPressed: () {}, isLoading: true),
          const _SectionTitle('Text field'),
          const AppTextField(
            label: 'Phone number',
            helperText: 'For example 07XX XXX XXX',
            keyboardType: TextInputType.phone,
          ),
          const _SectionTitle('Colours (provisional)'),
          const Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: <Widget>[
              _Swatch('Primary', AppColors.primary),
              _Swatch('Accent', AppColors.accent),
              _Swatch('Success', AppColors.success),
              _Swatch('Error', AppColors.error),
              _Swatch('Text', AppColors.textPrimary),
              _Swatch('Text 2', AppColors.textSecondary),
            ],
          ),
          const _SectionTitle('Screen states'),
          const Card(
            child: SizedBox(height: 120, child: LoadingView(message: 'Loading')),
          ),
          const Card(
            child: SizedBox(
              height: 220,
              child: EmptyStateView(
                icon: Icons.favorite_border_rounded,
                title: 'No favourites yet',
                message: 'Properties you save will appear here.',
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 260,
              child: ErrorStateView(
                message: 'Check your connection and try again.',
                onRetry: () {},
              ),
            ),
          ),
          const _SectionTitle('Money formats (sample data, provisional fees)'),
          for (final listing in sampleListings)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                '${listing.title}: ${formatKes(listing.rentKes)}, '
                'fee ${formatKes(provisionalFeeForRentKes(listing.rentKes))}',
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
