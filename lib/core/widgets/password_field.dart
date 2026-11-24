import 'package:flutter/material.dart';

import 'app_text_field.dart';

/// Password input with a show/hide control. Hidden by default.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.label = 'Password',
    this.controller,
    this.validator,
    this.helperText,
    this.textInputAction,
    this.autofillHints,
  });

  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? helperText;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      controller: widget.controller,
      validator: widget.validator,
      helperText: widget.helperText,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      obscureText: _isHidden,
      suffixIcon: IconButton(
        tooltip: _isHidden ? 'Show password' : 'Hide password',
        onPressed: () => setState(() => _isHidden = !_isHidden),
        icon: Icon(
          _isHidden
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
      ),
    );
  }
}
