import 'package:autth_injustice_app/authentication/presentation/widgets/button_primary.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/clouds.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/translate_button.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/routes/auth_routes.dart';
import 'package:autth_injustice_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with TickerProviderStateMixin {
  late final AnimationController _irisController;
  late final AnimationController _animController;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _buttonSlide;
  late final Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();

    _irisController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _irisController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.forward();
      }
    });

    _textSlide =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic)),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.0, 0.9, curve: Curves.easeOut)),
    );

    _buttonSlide =
        Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.1, 1.0, curve: Curves.easeOutCubic)),
    );
    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeIn)),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _irisController.forward();
      }
    });
  }

  @override
  void dispose() {
    _irisController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = context.colors;
    final textTheme = context.text;

    return Scaffold(
      backgroundColor: context.colors.tertiary,
      body: AnimatedBuilder(
        animation: _irisController,
        builder: (context, child) {
          return ClipPath(
            clipper: IrisClipper(_irisController.value),
            child: child,
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: context.initialPageGradient,
          ),
          child: SizedBox.expand(
            child: Stack(
              children: [
                const CloudBackground(),
                SafeArea(
                  child: Padding(
                    padding: context.extraPagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 50),
                        RepaintBoundary(
                          child: SlideTransition(
                            position: _textSlide,
                            child: FadeTransition(
                              opacity: _textOpacity,
                              child: Text(
                                '${context.l10n.welcomeTo}\n${context.l10n.whereIf}',
                                textAlign: TextAlign.start,
                                style: textTheme.headlineLarge?.copyWith(
                                  color: themeColors.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        RepaintBoundary(
                          child: SlideTransition(
                            position: _buttonSlide,
                            child: FadeTransition(
                              opacity: _buttonOpacity,
                              child: ButtonPrimary(
                                text: context.l10n.continueButton,
                                onTap: () {
                                  context.push(AuthPaths.login);
                                  //_animController.reverse().then((_) {
                                  //_irisController.reverse().then((_) {
                                  //});
                                  //});
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.spaceLg),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const TranslateButton(),
    );
  }
}

class IrisClipper extends CustomClipper<Path> {
  final double progress;

  IrisClipper(this.progress);

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);

    final maxRadius = center.distance;
    final radius = maxRadius * progress;

    path.addOval(Rect.fromCircle(center: center, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(covariant IrisClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}
