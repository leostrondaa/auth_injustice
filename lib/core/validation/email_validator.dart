import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';

class EmailValidator {
  const EmailValidator._();

  static String? validate(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.emailRequired;
    }

    final email = value.trim();

    final regex = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );

    if (!regex.hasMatch(email)) {
      return context.l10n.invalidEmail;
    }

    return null;
  }
}
