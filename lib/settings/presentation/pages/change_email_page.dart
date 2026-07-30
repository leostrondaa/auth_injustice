import 'dart:async';

import 'package:autth_injustice_app/authentication/presentation/navigation/auth_routes.dart';
import 'package:autth_injustice_app/authentication/presentation/navigation/check_email_args.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/validation/email_validator.dart';
import 'package:autth_injustice_app/settings/presentation/viewmodels/change_email/change_email_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/forms/auth_credential_step.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _pageController = PageController();
  final _currentPasswordController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _currentPasswordFocus = FocusNode();
  final _newEmailFocus = FocusNode();

  late final ChangeEmailViewModel _viewModel;
  int _currentPage = 0;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<ChangeEmailViewModel>();
    _viewModel.state.reset();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _currentPasswordFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPasswordController.dispose();
    _newEmailController.dispose();
    _currentPasswordFocus.dispose();
    _newEmailFocus.dispose();
    super.dispose();
  }

  Future<void> _nextStep() async {
    if (_isProcessing || _viewModel.state.loading.value) return;

    final step = _currentPage;
    final error = step == 0
        ? _validateCurrentPassword()
        : EmailValidator.validate(context, _newEmailController.text);

    if (error != null) {
      unawaited(_viewModel.state.showTemporaryError(error));
      return;
    }

    _setProcessing(true);

    try {
      if (step == 0) {
        FocusScope.of(context).unfocus();
        await _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        return;
      }

      final newEmail = _newEmailController.text.trim();
      await _viewModel.commands.requestEmailChange(
        currentPassword: _currentPasswordController.text,
        newEmail: newEmail,
      );

      if (!mounted || !_viewModel.state.success.value) return;
      _viewModel.state.setSuccess(false);

      final confirmed = await context.pushNamed<bool>(
        AuthRouteNames.checkEmail,
        extra: CheckEmailArgs(
          email: newEmail,
          flow: EmailVerificationFlow.changeEmail,
          linkAlreadySent: true,
        ),
      );

      if (!mounted || confirmed != true) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.accountEmailChanged)),
      );
      context.pop();
    } finally {
      _setProcessing(false);
    }
  }

  String? _validateCurrentPassword() {
    if (_currentPasswordController.text.isEmpty) {
      return context.l10n.accountCurrentPasswordRequired;
    }
    return null;
  }

  Future<void> _previousStep() async {
    FocusScope.of(context).unfocus();

    if (_currentPage == 0) {
      context.pop();
      return;
    }

    _viewModel.state.clearError();
    await _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _setProcessing(bool value) {
    if (_isProcessing == value) return;

    if (!mounted) {
      _isProcessing = value;
      return;
    }

    setState(() => _isProcessing = value);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.text.headlineLarge?.copyWith(
      color: context.colors.onTertiary,
      fontSize: context.isVerySmallScreen ? 28 : null,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colors.onError,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _currentPage = index);
          if (index == 0) {
            _currentPasswordFocus.requestFocus();
          } else {
            _newEmailFocus.requestFocus();
          }
        },
        children: [
          AuthCredentialStep(
            error: _viewModel.state.errorMessage.readonly(),
            loading: _viewModel.state.loading.readonly(),
            active: _currentPage == 0,
            isProcessing: _isProcessing,
            title: Text(
              context.l10n.accountCurrentPasswordTitle,
              style: titleStyle,
            ),
            label: context.l10n.accountCurrentPassword,
            controller: _currentPasswordController,
            focusNode: _currentPasswordFocus,
            textInputAction: TextInputAction.next,
            buttonText: context.l10n.continueButton,
            onNext: _nextStep,
            onBack: _previousStep,
            isPassword: true,
          ),
          AuthCredentialStep(
            error: _viewModel.state.errorMessage.readonly(),
            loading: _viewModel.state.loading.readonly(),
            active: _currentPage == 1,
            isProcessing: _isProcessing,
            title: Text(
              context.l10n.accountNewEmailTitle,
              style: titleStyle,
            ),
            label: context.l10n.accountNewEmail,
            controller: _newEmailController,
            focusNode: _newEmailFocus,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            buttonText: context.l10n.accountChangeEmail,
            onNext: _nextStep,
            onBack: _previousStep,
          ),
        ],
      ),
    );
  }
}
