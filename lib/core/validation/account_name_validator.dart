import 'package:autth_injustice_app/account/domain/models/account_name.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';

class AccountNameValidator {
  const AccountNameValidator._();

  static String? validate(
    BuildContext context, {
    required String firstName,
    required String lastName,
  }) {
    final name = AccountName(
      firstName: firstName,
      lastName: lastName,
    );

    if (!name.hasValidFirstName) {
      return context.l10n.invalidFirstName;
    }

    if (!name.hasValidLastName) {
      return context.l10n.invalidLastName;
    }

    return null;
  }
}
