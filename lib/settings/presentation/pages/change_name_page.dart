import 'dart:async';

import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/validation/account_name_validator.dart';
import 'package:autth_injustice_app/settings/presentation/viewmodels/change_name/change_name_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/forms/auth_credential_step.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangeNamePage extends StatefulWidget {
  const ChangeNamePage({super.key});

  @override
  State<ChangeNamePage> createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();

  late final ChangeNameViewModel _viewModel;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<ChangeNameViewModel>();
    _viewModel.state.reset();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_loadCurrentName());
    });
  }

  Future<void> _loadCurrentName() async {
    await _viewModel.commands.loadCurrentName();
    if (!mounted) return;

    final currentName = _viewModel.state.currentName.value;
    if (currentName != null) {
      _firstNameController.text = currentName.firstName;
      _lastNameController.text = currentName.lastName;
    }

    _firstNameFocus.requestFocus();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isProcessing || _viewModel.state.loading.value) return;

    final error = AccountNameValidator.validate(
      context,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
    );
    if (error != null) {
      unawaited(_viewModel.state.showTemporaryError(error));
      return;
    }

    _setProcessing(true);
    FocusScope.of(context).unfocus();

    try {
      await _viewModel.commands.updateName(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );

      if (!mounted || !_viewModel.state.success.value) return;
      _viewModel.state.setSuccess(false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.accountNameChanged)),
      );
      context.pop();
    } finally {
      _setProcessing(false);
    }
  }

  void _setProcessing(bool value) {
    if (_isProcessing == value) return;

    if (!mounted) {
      _isProcessing = value;
      return;
    }

    setState(() => _isProcessing = value);
  }

  void _goBack() {
    FocusScope.of(context).unfocus();
    context.pop();
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
      body: AuthCredentialStep(
        error: _viewModel.state.errorMessage.readonly(),
        loading: _viewModel.state.loading.readonly(),
        active: true,
        isProcessing: _isProcessing,
        title: Text(
          context.l10n.accountNewNameTitle,
          style: titleStyle,
        ),
        label: context.l10n.firstName,
        controller: _firstNameController,
        focusNode: _firstNameFocus,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        autofillHints: const [AutofillHints.givenName],
        secondaryLabel: context.l10n.lastName,
        secondaryController: _lastNameController,
        secondaryFocusNode: _lastNameFocus,
        secondaryKeyboardType: TextInputType.name,
        secondaryTextInputAction: TextInputAction.done,
        secondaryTextCapitalization: TextCapitalization.words,
        secondaryAutofillHints: const [AutofillHints.familyName],
        buttonText: context.l10n.accountChangeName,
        onNext: _submit,
        onBack: _goBack,
      ),
    );
  }
}
