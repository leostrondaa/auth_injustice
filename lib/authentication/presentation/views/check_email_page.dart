import 'package:autth_injustice_app/authentication/presentation/widgets/back_button.dart';
import 'package:autth_injustice_app/core/constants/app_assets.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/routes/route_args/check_email_args.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CheckEmailPage extends StatefulWidget {
  final CheckEmailArgs args;

  const CheckEmailPage({
    super.key,
    required this.args,
  });

  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage>
    with TickerProviderStateMixin {
  late final AnimationController _contentController;

  late final Animation<double> _iconScale;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _textSlide =
        Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _contentController.forward();
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  // Função para reverter a animação antes de sair
  Future<void> _handlePop() async {
    await _contentController.reverse();
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handlePop();
      },
      child: Scaffold(
        backgroundColor: context.colors.onError,
        body: SizedBox.expand(
          child: Stack(
            fit: StackFit.expand,
            children: [
              SafeArea(
                child: Padding(
                  padding: context.extraPagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Botão de voltar
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: _handlePop,
                          child: const BackButtonWidget(),
                        ),
                      ),

                      const Spacer(),

                      // ÍCONE ANIMADO
                      ScaleTransition(
                        scale: _iconScale,
                        child: Center(
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: context.colors.tertiary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: context.colors.onTertiary
                                      .withOpacity(0.4),
                                  blurRadius: 30,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.vectorIcon,
                                height: 40,
                                colorFilter: ColorFilter.mode(
                                  context.colors.onTertiary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: context.isVerySmallScreen ? 32 : 48),

                      // TÍTULO E TEXTO FLUIDO
                      SlideTransition(
                        position: _textSlide,
                        child: FadeTransition(
                          opacity: _textOpacity,
                          child: Column(
                            children: [
                              Text(
                                '${context.l10n.checkEmailTitle}',
                                textAlign: TextAlign.center,
                                style: context.text.headlineLarge?.copyWith(
                                  color: context.colors.onTertiary,
                                  fontSize:
                                      context.isVerySmallScreen ? 28 : null,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: context.text.bodyLarge?.copyWith(
                                      color: context.colors.onTertiary
                                          .withOpacity(0.7),
                                      height: 1.5,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${context.l10n.checkEmailSentTo}\n',
                                      ),
                                      TextSpan(
                                        text: widget.args.email,
                                        style: TextStyle(
                                          color: context.colors.secondary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '\n\n${context.l10n.checkEmailDescription}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
