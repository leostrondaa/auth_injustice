import 'dart:async';

import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/validators/password_validator.dart';
import 'package:autth_injustice_app/settings/presentation/viewmodels/change_password/change_password_viewmodel.dart';
import 'package:autth_injustice_app/settings/presentation/widgets/account/account_credential_step.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _pageController = PageController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _currentPasswordFocus = FocusNode();
  final _newPasswordFocus = FocusNode();

  late final ChangePasswordViewModel _viewModel;
  int _currentPage = 0;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<ChangePasswordViewModel>();
    _viewModel.state.reset();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _currentPasswordFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    super.dispose();
  }

  Future<void> _nextStep() async {
    if (_isProcessing || _viewModel.state.loading.value) return;

    final step = _currentPage;
    final error =
        step == 0 ? _validateCurrentPassword() : _validateNewPassword();

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

      await _viewModel.commands.changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      );

      if (!mounted || !_viewModel.state.success.value) return;

      _viewModel.state.setSuccess(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.accountPasswordChanged)),
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

  String? _validateNewPassword() {
    final error = PasswordValidator.validate(
      context,
      _newPasswordController.text,
    );
    if (error != null) return error;

    if (_newPasswordController.text == _currentPasswordController.text) {
      return context.l10n.accountPasswordMustDiffer;
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
            _newPasswordFocus.requestFocus();
          }
        },
        children: [
          AccountCredentialStep(
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
            showPasswordStrength: false,
          ),
          AccountCredentialStep(
            error: _viewModel.state.errorMessage.readonly(),
            loading: _viewModel.state.loading.readonly(),
            active: _currentPage == 1,
            isProcessing: _isProcessing,
            title: Text(
              context.l10n.accountNewPasswordTitle,
              style: titleStyle,
            ),
            label: context.l10n.accountNewPassword,
            controller: _newPasswordController,
            focusNode: _newPasswordFocus,
            textInputAction: TextInputAction.done,
            buttonText: context.l10n.accountChangePasswordButton,
            onNext: _nextStep,
            onBack: _previousStep,
            isPassword: true,
            showPasswordStrength: true,
          ),
        ],
      ),
    );
  }
}
