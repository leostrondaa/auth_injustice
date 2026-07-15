import 'dart:ui';

import 'package:autth_injustice_app/authentication/presentation/controllers/register/register_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/back_button.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/button_primary.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/auth_error_banner.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/password_strength_indicator.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/textfield.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/translate_button.dart';
import 'package:autth_injustice_app/core/constants/app_assets.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/utils/hide_keyboard.dart';
import 'package:autth_injustice_app/core/validators/email_validator.dart';
import 'package:autth_injustice_app/core/validators/passworld_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _pageController = PageController();

  final _emailCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final _emailFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _passFocus = FocusNode();

  late final _stepFocusNodes = [_emailFocus, _nameFocus, _passFocus];
  int _currentPage = 0;

  late final RegisterViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = injector.get<RegisterViewModel>();

    _passCtrl.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _focusStep(0));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.dispose();
    _nameFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _focusStep(int index) {
    if (!mounted) return;
    FocusScope.of(context).requestFocus(_stepFocusNodes[index]);
  }

  void _goToStep(int index) {
    FocusScope.of(context).unfocus();

    _pageController.jumpToPage(index);
    _focusStep(index);
  }

  Future<void> _nextStep() async {
    if (_currentPage == 0) {
      final error = EmailValidator.validate(
        context,
        _emailCtrl.text,
      );

      if (error != null) {
        await _viewModel.state.showTemporaryError(error);
        return;
      }
    }

    if (_currentPage == 1) {
      final error = PasswordValidator.validate(
        context,
        _passCtrl.text,
      );

      if (error != null) {
        await _viewModel.state.showTemporaryError(error);
        return;
      }
    }

    FocusScope.of(context).unfocus();

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _previousStep() async {
    FocusScope.of(context).unfocus();

    if (_pageController.page?.round() == 0) {
      context.pop();
      return;
    }

    _viewModel.state.clearError();
    await _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CRUCIAL: Impede que a tela inteira esprema/suba quando o teclado abrir
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colors.onError,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });

          switch (index) {
            case 0:
              _emailFocus.requestFocus();
              break;
            case 1:
              _passFocus.requestFocus();
              break;
          }
        },
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SignupStepGeneric(
            viewModel: _viewModel,
            active: _currentPage == 0,
            validator: (value) => EmailValidator.validate(context, value),
            onBack: _previousStep,
            title: Text(
              '${context.l10n.whatYour}\n${context.l10n.email}',
              textAlign: TextAlign.start,
              style: context.text.headlineLarge?.copyWith(
                color: context.colors.onTertiary,
                fontSize: context.isVerySmallScreen ? 28 : null,
              ),
            ),
            label: context.l10n.email,
            controller: _emailCtrl,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
            buttonText: context.l10n.continueButton,
            textInputAction: TextInputAction.next,
            onNext: _nextStep,
          ),
          SignupStepGeneric(
            viewModel: _viewModel,
            active: _currentPage == 1,
            validator: (value) => PasswordValidator.validate(context, value),
            onBack: _previousStep,
            title: Text(
              '${context.l10n.createPassword}\n${context.l10n.password}',
              textAlign: TextAlign.start,
              style: context.text.headlineLarge?.copyWith(
                color: context.colors.onTertiary,
                fontSize: context.isVerySmallScreen ? 28 : null,
              ),
            ),
            label: context.l10n.password,
            controller: _passCtrl,
            focusNode: _passFocus,
            obscureText: true,
            showPasswordStrength: true,
            buttonText: context.l10n.continueButton,
            textInputAction: TextInputAction.done,
            onNext: _nextStep,
          ),
        ],
      ),
      floatingActionButton: const TranslateButton(),
    );
  }
}

class SignupStepGeneric extends StatefulWidget {
  final bool active;
  final Widget title;
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final String buttonText;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool showPasswordStrength;
  final RegisterViewModel viewModel;
  final String? Function(String?)? validator;

  const SignupStepGeneric({
    super.key,
    required this.active,
    required this.title,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.onNext,
    required this.onBack,
    required this.validator,
    required this.viewModel,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.buttonText = 'Continue',
    this.showPasswordStrength = false,
  });

  @override
  State<SignupStepGeneric> createState() => _SignupStepGenericState();
}

class _SignupStepGenericState extends State<SignupStepGeneric>
    with TickerProviderStateMixin {
  late final AnimationController _irisController;
  late final AnimationController _contentController;

  late final Animation<Offset> _textSlide;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _buttonSlide;
  late final Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();

    _irisController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _irisController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _contentController.forward();
    });

    _textSlide =
        Tween<Offset>(begin: const Offset(0, -0.8), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.9, curve: Curves.easeOut),
      ),
    );

    _buttonSlide =
        Tween<Offset>(begin: const Offset(0, 0.8), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.1, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    if (widget.active) _playEntrance();
  }

  @override
  void didUpdateWidget(covariant SignupStepGeneric oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) _playEntrance();
  }

  void _playEntrance() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _irisController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _irisController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. IMAGEM DE FUNDO (Acompanha a largura da tela)
          Positioned(
            left: 0,
            bottom: -150,
            child: Transform.rotate(
              angle: -0.8,
              child: Image.asset(
                context.isDarkMode
                    ? AppAssets.ifLogoWhite
                    : AppAssets.ifLogoBlack,
                width: context.screenSize.width, // Usa 100% da tela natural
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 2. CONTEÚDO VISUAL (Formulário fluindo livremente na tela)
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: context.extraPagePadding.copyWith(bottom: 0, top: 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: BackButtonWidget(onTap: widget.onBack),
                  ),
                ),

                // O ScrollView pega toda a área acima do botão
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: context.extraPagePadding.copyWith(
                      bottom: keyboardHeight +
                          80, // Mantém a rolagem segura do teclado
                      top: context.headerTopSpacing,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SlideTransition(
                          position: _textSlide,
                          child: FadeTransition(
                            opacity: _textOpacity,
                            child: widget.title,
                          ),
                        ),
                        SizedBox(height: context.formTopSpacing),
                        SlideTransition(
                          position: _textSlide,
                          child: FadeTransition(
                            opacity: _textOpacity,
                            child: CustomTextField(
                              controller: widget.controller,
                              focusNode: widget.focusNode,
                              hintText: widget.label,
                              keyboardType: widget.keyboardType,
                              isPassword: widget.obscureText,
                              textInputAction: widget.textInputAction,
                              onFieldSubmitted: (_) => widget.onNext(),
                            ),
                          ),
                        ),
                        AuthErrorBanner(
                          error: widget.viewModel.state.errorMessage.readonly(),
                        ),
                        if (widget.obscureText) ...[
                          const SizedBox(height: 25),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color:
                                      context.colors.onError.withOpacity(0.45),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.15),
                                  ),
                                ),
                                child: PasswordStrengthIndicator(
                                  controller: widget.controller,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. BOTÃO FIXO NO RODAPÉ (Sem limitador central)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: context.extraPagePadding.copyWith(
                  top: 16,
                  bottom: context.isVerySmallScreen ? 16 : 32,
                ),
                child: SlideTransition(
                  position: _buttonSlide,
                  child: FadeTransition(
                    opacity: _buttonOpacity,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ButtonPrimary(
                        text: widget.buttonText,
                        onTap: widget.onNext,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
