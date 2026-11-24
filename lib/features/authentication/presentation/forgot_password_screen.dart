import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/prototype_notice.dart';
import '../../../features/prototype/prototype_delay.dart';

/// Password recovery request (FR-AUTH-04).
///
/// The confirmation never says whether an account exists for the email, so
/// the screen cannot be used to discover who has an account.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isSubmitting = false;
  String? _sentTo;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isSubmitting = true);
    await simulateNetworkDelay();
    if (!mounted) {
      return;
    }
    setState(() {
      _isSubmitting = false;
      _sentTo = _emailController.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: _sentTo == null ? _buildForm() : _buildConfirmation(_sentTo!),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Enter the email you signed up with and we will send you a link '
            'to choose a new password.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Email',
            controller: _emailController,
            validator: validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofillHints: const <String>[AutofillHints.email],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Send reset link',
            onPressed: _submit,
            isLoading: _isSubmitting,
          ),
          const PrototypeNotice(),
        ],
      ),
    );
  }

  Widget _buildConfirmation(String email) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: AppSpacing.lg),
        const Icon(
          Icons.mark_email_read_outlined,
          size: 64,
          color: AppColors.primary,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Check your email',
          style: textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'If an account exists for $email, we have sent a link to reset '
          'your password.',
          style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: 'Back to sign in',
          onPressed: () => Navigator.of(context).pop(),
        ),
        const PrototypeNotice(),
      ],
    );
  }
}
