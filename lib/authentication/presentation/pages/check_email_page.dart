import 'dart:async';

import 'package:autth_injustice_app/authentication/presentation/viewmodels/check_email/check_email_viewmodel.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/buttons/auth_back_button.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/feedback/email_confirmation_feedback.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/constants/app_assets.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/authentication/presentation/navigation/check_email_args.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/map/presentation/navigation/map_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

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
  static const _successFeedbackDuration = Duration(seconds: 3);

  late final CheckEmailViewModel _viewModel;
  late final AnimationController _contentController;
  late final Animation<double> _iconScale;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _textOpacity;

  Timer? _redirectTimer;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<CheckEmailViewModel>();
    _viewModel.state.reset();

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
      if (!mounted) return;

      _contentController.forward();
      _startEmailConfirmation();
    });
  }

  Future<void> _startEmailConfirmation() async {
    await _viewModel.commands.waitForConfirmation(email: widget.args.email);
    if (!mounted || !_viewModel.state.confirmed.value) return;

    _redirectTimer = Timer(_successFeedbackDuration, () {
      if (!mounted) return;
      _handleConfirmedRedirect();
    });
  }

  @override
  void dispose() {
    _redirectTimer?.cancel();
    _contentController.dispose();
    super.dispose();
  }

  String _confirmedTitle(BuildContext context) {
    return switch (widget.args.flow) {
      CheckEmailFlow.register => context.l10n.emailConfirmedTitle,
      CheckEmailFlow.forgotPassword => context.l10n.emailConfirmedTitle,
      CheckEmailFlow.changeEmail => context.l10n.accountEmailChangedTitle,
    };
  }

  String _confirmedSubtitle(BuildContext context) {
    return switch (widget.args.flow) {
      CheckEmailFlow.register => context.l10n.accountConfirmedSubtitle,
      CheckEmailFlow.forgotPassword => context.l10n.emailConfirmedSubtitle,
      CheckEmailFlow.changeEmail => context.l10n.accountEmailChangedSubtitle,
    };
  }

  void _handleConfirmedRedirect() {
    switch (widget.args.flow) {
      case CheckEmailFlow.register:
        context.goNamed(MapRouteNames.map);
        break;

      case CheckEmailFlow.forgotPassword:
        // context.pushReplacement(AuthPaths.resetPassword);
        break;

      case CheckEmailFlow.changeEmail:
        context.pop(true);
        break;
    }
  }

  Future<void> _handlePop() async {
    await _contentController.reverse();
    if (mounted) context.pop(false);
  }

  Widget _buildWaitingEmailContent(BuildContext context) {
    final isCompact = context.isVerySmallScreen;
    return Column(
      key: const ValueKey('waiting-email'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
                    color: context.colors.onTertiary.withValues(alpha: 0.4),
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
        SlideTransition(
          position: _textSlide,
          child: FadeTransition(
            opacity: _textOpacity,
            child: Column(
              children: [
                Text(
                  context.l10n.checkEmailTitle,
                  textAlign: TextAlign.center,
                  style: context.text.headlineLarge?.copyWith(
                    color: context.colors.onTertiary,
                    fontSize: context.isVerySmallScreen ? 28 : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: context.colors.onTertiary.withValues(alpha: 0.7),
                        height: 1.5,
                        fontSize: isCompact
                            ? context.text.labelMedium?.fontSize
                            : context.text.labelLarge?.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: '${context.l10n.checkEmailSentTo}\n'),
                        TextSpan(
                          text: widget.args.email,
                          style: TextStyle(
                            color: context.colors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '\n\n${context.l10n.checkEmailDescription}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: _handlePop,
                          child: const AuthBackButton(),
                        ),
                      ),
                      Expanded(
                        child: Watch(
                          (_) => AnimatedSwitcher(
                            duration: const Duration(milliseconds: 450),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            child: _viewModel.state.confirmed.value
                                ? EmailConfirmationFeedback(
                                    key: const ValueKey('email-confirmed'),
                                    title: _confirmedTitle(context),
                                    subtitle: _confirmedSubtitle(context),
                                  )
                                : _buildWaitingEmailContent(context),
                          ),
                        ),
                      ),
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
