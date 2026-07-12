import 'package:autth_injustice_app/authentication/presentation/widgets/button_primary.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/clouds.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/text_button.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/textfield.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/routes/app_routes.dart';
import 'package:autth_injustice_app/core/routes/auth_routes.dart';
import 'package:flutter/material.dart' hide TextButton;
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../core/theme/app_theme.dart';
import '../controllers/auth_session_viewmodel.dart';
import '../widgets/auth_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late final AnimationController _animController;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _headerOpacity;
  late final Animation<Offset> _sheetSlide;
  late final Animation<double> _formOpacity;
  late final Animation<Offset> _formSlide;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _headerSlide =
        Tween<Offset>(begin: const Offset(0, 0.9), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic)),
    );
    _headerOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );

    _sheetSlide =
        Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic)),
    );

    _formOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _formSlide = Tween<Offset>(
      begin: const Offset(0.3, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: context.initialPageGradient,
        ),
        child: Stack(
          children: [
            const CloudBackground(),
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
                            'Junte-se ao\nTime!',
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
            Positioned(
              top: size.height * 0.38,
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: _sheetSlide,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.tertiary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.onSecondary.withOpacity(0.22),
                        blurRadius: 100,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SingleChildScrollView(
                      padding: context.extraPagePadding,
                      child: SlideTransition(
                        position: _formSlide,
                        child: FadeTransition(
                          opacity: _formOpacity,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 40),
                                const CustomTextField(
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 16),
                                const CustomTextField(
                                  hintText: 'Senha',
                                  isPassword: true,
                                ),
                                const SizedBox(height: 12),
                                TextButton(
                                  text: 'Esqueceu sua senha?',
                                  color: const Color(
                                      0xFF757575), // Passando a cor por parâmetro
                                  onTap: () {
                                    // Sua lógica de navegação ou controle aqui
                                  },
                                ),
                                const SizedBox(height: 40),
                                ButtonPrimary(
                                  text: 'Entrar',
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();

                                      _animController.reverse().then((_) {
                                        context.go(AuthPaths.initial);
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(height: 12),
                                Center(
                                  child: TextButtonRich(
                                    baseText: 'Não tem uma conta? ',
                                    actionText: 'Sign Up',
                                    actionColor: const Color(
                                        0xFF9B51E0), // Cor roxa destacada
                                    onTap: () {
                                      context.go(AuthPaths.initial);
                                    },
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
                                      child: Text('or',
                                          style: TextStyle(
                                              color: Colors.grey.shade500)),
                                    ),
                                    Expanded(
                                        child: Divider(
                                            color: Colors.grey.shade800,
                                            thickness: 1)),
                                  ],
                                ),
                                const SizedBox(height: 48),
                                Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5EBE6),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.g_mobiledata,
                                          color: Colors.blue, size: 36),
                                      Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(Icons.arrow_forward,
                                          color: Colors.grey, size: 20),
                                    ],
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
