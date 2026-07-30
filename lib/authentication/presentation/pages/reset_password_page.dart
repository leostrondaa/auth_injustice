import 'dart:async';

import 'package:autth_injustice_app/authentication/presentation/navigation/auth_routes.dart';
import 'package:autth_injustice_app/authentication/presentation/navigation/password_reset_args.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/password_reset/password_reset_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/feedback/email_confirmation_feedback.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/forms/auth_credential_step.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/validation/password_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ResetPasswordPage extends StatefulWidget {
  final PasswordResetArgs args;

  const ResetPasswordPage({
    super.key,
    required this.args,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  static const _successDuration = Duration(seconds: 3);

  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmationFocus = FocusNode();

  late final PasswordResetViewModel _viewModel;
  Timer? _redirectTimer;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<PasswordResetViewModel>();
    _viewModel.state.reset();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _passwordFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _redirectTimer?.cancel();
    _passwordController.dispose();
    _confirmationController.dispose();
    _passwordFocus.dispose();
    _confirmationFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isProcessing || _viewModel.state.loading.value) return;

    final validation = PasswordValidator.validate(
      context,
      _passwordController.text,
    );
    if (validation != null) {
      _viewModel.state.showError(validation);
      return;
    }
    if (_passwordController.text != _confirmationController.text) {
      _viewModel.state.showError('passwordResetMismatch');
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isProcessing = true);

    try {
      final success = await _viewModel.commands.resetPassword(
        email: widget.args.email,
        actionCode: widget.args.actionCode,
        newPassword: _passwordController.text,
      );
      if (!mounted || !success) return;

      _redirectTimer?.cancel();
      _redirectTimer = Timer(_successDuration, _goToLogin);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _goToLogin() {
    if (mounted) context.go(AuthPaths.login);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.text.headlineLarge?.copyWith(
      color: context.colors.onTertiary,
      fontSize: context.isVerySmallScreen ? 28 : null,
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goToLogin();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.colors.onError,
        body: Watch(
          (_) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _viewModel.state.success.value
                ? EmailConfirmationFeedback(
                    key: const ValueKey('password-reset-success'),
                    title: context.l10n.passwordResetChangedTitle,
                    subtitle: context.l10n.passwordResetChangedSubtitle,
                  )
                : AuthCredentialStep(
                    key: const ValueKey('password-reset-form'),
                    error: _viewModel.state.errorMessage.readonly(),
                    loading: _viewModel.state.loading.readonly(),
                    active: true,
                    isProcessing: _isProcessing,
                    title: Text(
                      context.l10n.passwordResetTitle,
                      style: titleStyle,
                    ),
                    label: context.l10n.accountNewPassword,
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.newPassword],
                    secondaryLabel: context.l10n.passwordResetConfirmation,
                    secondaryController: _confirmationController,
                    secondaryFocusNode: _confirmationFocus,
                    secondaryTextInputAction: TextInputAction.done,
                    secondaryAutofillHints: const [
                      AutofillHints.newPassword,
                    ],
                    secondaryIsPassword: true,
                    buttonText: context.l10n.passwordResetButton,
                    onNext: _submit,
                    onBack: _goToLogin,
                    isPassword: true,
                    showPasswordStrength: true,
                  ),
          ),
        ),
      ),
    );
  }
}
