import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/prototype_notice.dart';
import '../../../features/prototype/prototype_delay.dart';
import '../../../shared/models/user_role.dart';
import 'email_verification_screen.dart';
import 'sign_in_screen.dart';

/// Account creation for a tenant or a landlord (FR-AUTH-02, FR-AUTH-03).
///
/// Collects only an email and a Kenyan phone number, plus a password
/// (D7, data minimisation 8.5). Landlords must also agree that their number
/// is shown to paying tenants (FR-AUTH-07; wording provisional, Q12).
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.role});

  final UserRole role;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSubmitting = false;

  bool get _isLandlord => widget.role == UserRole.landlord;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
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
    setState(() => _isSubmitting = false);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => EmailVerificationScreen(
          email: _emailController.text.trim(),
          role: widget.role,
        ),
      ),
    );
  }

  void _openSignIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create ${widget.role.label.toLowerCase()} account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppTextField(
                  label: 'Email',
                  controller: _emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const <String>[AutofillHints.email],
                  helperText: 'We will send a verification link to this address.',
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'Phone number',
                  controller: _phoneController,
                  validator: validateKenyanPhone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  autofillHints: const <String>[
                    AutofillHints.telephoneNumber,
                  ],
                  helperText: _isLandlord
                      ? 'Shown to tenants who have paid to view your listing.'
                      : 'Used to send the M-PESA payment prompt.',
                ),
                const SizedBox(height: AppSpacing.md),
                PasswordField(
                  controller: _passwordController,
                  validator: validatePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const <String>[AutofillHints.newPassword],
                  helperText:
                      'At least $provisionalMinPasswordLength characters.',
                ),
                if (_isLandlord) ...<Widget>[
                  const SizedBox(height: AppSpacing.sm),
                  const _LandlordConsentField(),
                ],
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: 'Create account',
                  onPressed: _submit,
                  isLoading: _isSubmitting,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: _openSignIn,
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

/// Landlord agreement that their phone number is shown to paying tenants
/// (FR-AUTH-07). The wording is provisional until Q12 is answered.
class _LandlordConsentField extends StatelessWidget {
  const _LandlordConsentField();

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: false,
      validator: (bool? agreed) =>
          agreed == true ? null : 'You must agree to continue.',
      builder: (FormFieldState<bool> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: state.value ?? false,
              onChanged: (bool? value) => state.didChange(value),
              title: const Text(
                'I agree that my phone number will be shown to tenants '
                'who have paid to view my listing.',
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.sm),
                child: Text(
                  state.errorText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                      ),
                ),
              ),
          ],
        );
      },
    );
  }
}
