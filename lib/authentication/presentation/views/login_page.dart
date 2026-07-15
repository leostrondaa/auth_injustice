import 'package:autth_injustice_app/authentication/presentation/controllers/login/login_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/animation_error.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/button_primary.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/clouds.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/google_button.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/loading_overlay.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/auth_error_banner.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/text_button.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/textfield.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/translate_button.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/routes/app_routes.dart';
import 'package:autth_injustice_app/core/routes/auth_routes.dart';
import 'package:autth_injustice_app/core/utils/hide_keyboard.dart';
import 'package:autth_injustice_app/core/validators/email_validator.dart';
import 'package:autth_injustice_app/core/validators/passworld_validator.dart';
import 'package:flutter/material.dart' hide TextButton;
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../core/theme/app_theme.dart';
import '../widgets/auth_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final LoginViewModel _viewModel;

  late final TextEditingController _emailCtrl;
  late final TextEditingController _passCtrl;

  late final AnimationController _animController;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _headerOpacity;
  late final Animation<Offset> _sheetSlide;
  late final Animation<double> _formOpacity;
  late final Animation<Offset> _formSlide;

  @override
  void initState() {
    super.initState();

    _viewModel = injector.get<LoginViewModel>();

    _emailCtrl = TextEditingController();
    _passCtrl = TextEditingController();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    const premiumCurve = Curves.easeOutQuint;

    _headerSlide =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _headerOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _sheetSlide =
        Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic)),
    );

    _formSlide =
        Tween<Offset>(begin: const Offset(0.25, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.3, 0.8, curve: premiumCurve)),
    );

    _formOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.3, 0.8, curve: Curves.easeIn)),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;

    if (email.isEmpty || password.isEmpty) {
      _viewModel.state.showError(
          context.l10n.fieldsRequired ?? "Por favor, insira seus dados.");
      return;
    }

    final emailError = EmailValidator.validate(context, email);
    final passwordError = PasswordValidator.validate(context, password);

    if (emailError != null || passwordError != null) {
      _viewModel.state.showError(
          context.l10n.invalidFields ?? "E-mail ou senha incorretos.");
      return;
    }

    await _viewModel.commands.signIn(
      email: email,
      password: password,
    );

    await _animController.reverse();

    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;

    return LoadingOverlay(
      loading: _viewModel.state.loading,
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: context.initialPageGradient,
            ),
            child: Stack(
              children: [
                const CloudBackground(),

                // HEADER (Fica fixo no topo)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: context.extraPagePadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 50),
                          SlideTransition(
                            position: _headerSlide,
                            child: FadeTransition(
                              opacity: _headerOpacity,
                              child: Text(
                                '${context.l10n.joinThe}\n${context.l10n.team}',
                                textAlign: TextAlign.start,
                                style: context.text.headlineLarge?.copyWith(
                                  color: context.colors.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // BOTTOM SHEET (Posicionado exatamente a 38% do topo igual antes)
                Positioned(
                  top: size.height * 0.38,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SlideTransition(
                    position: _sheetSlide,
                    child: RepaintBoundary(
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colors.tertiary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  context.colors.onSecondary.withOpacity(0.18),
                              blurRadius: 50,
                              offset: const Offset(0, -5),
                            )
                          ],
                        ),
                        child: SafeArea(
                          top: false,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: context.extraPagePadding.copyWith(
                              bottom: context.extraPagePadding.bottom +
                                  keyboardHeight,
                            ),
                            child: SlideTransition(
                              position: _formSlide,
                              child: FadeTransition(
                                opacity: _formOpacity,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 40),
                                      CustomTextField(
                                        controller: _emailCtrl,
                                        hintText: context.l10n.email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextField(
                                        controller: _passCtrl,
                                        hintText: context.l10n.password,
                                        isPassword: true,
                                      ),
                                      AuthErrorBanner(
                                        error: _viewModel.state.errorMessage,
                                      ),
                                      const SizedBox(height: 12),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextButton(
                                          style: context.text.displaySmall
                                              ?.copyWith(fontSize: 14),
                                          text: context.l10n.forgot,
                                          color: const Color(0xFF757575),
                                          onTap: () {},
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      ButtonPrimary(
                                        text: context.l10n.loginButton,
                                        onTap: _handleLogin,
                                      ),
                                      const SizedBox(height: 12),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: TextButtonRich(
                                            style: context.text.displaySmall
                                                ?.copyWith(fontSize: 14),
                                            baseText:
                                                context.l10n.dontHaveAccount,
                                            actionText:
                                                context.l10n.signupButton,
                                            actionColor:
                                                const Color(0xFF9B51E0),
                                            onTap: () {
                                              hideKeyboard();
                                              context.push(AuthPaths.register);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 48),
                                      Row(
                                        children: [
                                          const Expanded(
                                              child: Divider(
                                                  color: Color(0xFF424242),
                                                  thickness: 1)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              context.l10n.or,
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                          ),
                                          Expanded(
                                              child: Divider(
                                                  color: Colors.grey.shade800,
                                                  thickness: 1)),
                                        ],
                                      ),
                                      const SizedBox(height: 48),
                                      GoogleSignInButton(
                                        onTap: () {
                                          print('Disparou o login do Google');
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const TranslateButton(),
      ),
    );
  }
}
