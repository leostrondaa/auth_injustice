import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';

class PasswordValidator {
  const PasswordValidator._();

  static final RegExp _lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp _uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp _numberRegex = RegExp(r'\d');
  static final RegExp _symbolRegex =
      RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]~`]');

  static String? validate(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.l10n.passwordRequired;
    }

    final strength = analyze(value, context: context);

    if (!strength.hasMinLength) {
      return context.l10n.passwordMinLength;
    }

    if (!strength.hasLetter) {
      return context.l10n.passwordRequireLowercaseAndUppercase;
    }

    if (!strength.hasNumber) {
      return context.l10n.passwordRequireNumber;
    }

    if (!strength.hasSymbol) {
      return context.l10n.passwordRequireSymbol;
    }

    return null;
  }

  static PasswordStrength analyze(String password, {BuildContext? context}) {
    final hasMinLength = password.length >= 8;
    final hasLowercase = _lowercaseRegex.hasMatch(password);
    final hasUppercase = _uppercaseRegex.hasMatch(password);
    final hasNumber = _numberRegex.hasMatch(password);
    final hasSymbol = _symbolRegex.hasMatch(password);

    final hasLetter = hasLowercase || hasUppercase;
    final meetsMinimum = hasMinLength && hasLetter && hasNumber && hasSymbol;
    final matchedRequirements = [
      hasMinLength,
      hasLetter,
      hasNumber,
      hasSymbol,
    ].where((isMet) => isMet).length;

    // A senha só chega em "Boa" quando cumpre todos os requisitos obrigatórios.
    // Uma letra maiúscula é um bônus de qualidade, não uma exigência para cadastrar.
    final double progress = switch (matchedRequirements) {
      0 => 0,
      1 => 0.25,
      2 || 3 => 0.5,
      _ when meetsMinimum && hasUppercase => 1,
      _ => 0.75,
    };

    final String message;
    if (context != null) {
      message = switch (progress) {
        0 => context.l10n.passwordStrengthEmpty,
        <= 0.20 => context.l10n.passwordStrengthVeryWeak,
        <= 0.40 => context.l10n.passwordStrengthWeak,
        <= 0.60 => context.l10n.passwordStrengthFair,
        <= 0.80 => context.l10n.passwordStrengthGood,
        _ => context.l10n.passwordStrengthExcellent,
      };
    } else {
      message = switch (progress) {
        0 => 'Digite uma senha',
        <= 0.20 => 'Muito fraca',
        <= 0.40 => 'Fraca',
        <= 0.60 => 'Razoável',
        <= 0.80 => 'Boa',
        _ => 'Excelente',
      };
    }

    return PasswordStrength(
      progress: progress,
      message: message,
      hasMinLength: hasMinLength,
      hasLetter: hasLetter,
      hasLowercase: hasLowercase,
      hasUppercase: hasUppercase,
      hasNumber: hasNumber,
      hasSymbol: hasSymbol,
    );
  }
}

class PasswordStrength {
  final double progress;
  final String message;

  final bool hasMinLength;
  final bool hasLetter;
  final bool hasLowercase;
  final bool hasUppercase;
  final bool hasNumber;
  final bool hasSymbol;

  const PasswordStrength({
    required this.progress,
    required this.message,
    required this.hasMinLength,
    required this.hasLetter,
    required this.hasLowercase,
    required this.hasUppercase,
    required this.hasNumber,
    required this.hasSymbol,
  });

  bool get isValid => hasMinLength && hasLetter && hasNumber && hasSymbol;
}
