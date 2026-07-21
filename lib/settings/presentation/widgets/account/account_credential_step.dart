import 'dart:ui';

import 'package:autth_injustice_app/authentication/presentation/widgets/buttons/auth_back_button.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/feedback/auth_error_banner.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/forms/auth_text_field.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/forms/password_strength_indicator.dart';
import 'package:autth_injustice_app/core/constants/app_assets.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_action_button.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AccountCredentialStep extends StatefulWidget {
  final bool active;
  final bool isProcessing;
  final Widget title;
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String buttonText;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isPassword;
  final bool showPasswordStrength;
  final ReadonlySignal<String?> error;
  final ReadonlySignal<bool> loading;

  const AccountCredentialStep({
    super.key,
    required this.active,
    required this.isProcessing,
    required this.title,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.textInputAction,
    required this.buttonText,
    required this.onNext,
    required this.onBack,
    required this.error,
    required this.loading,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.showPasswordStrength = false,
  });

  @override
  State<AccountCredentialStep> createState() => _AccountCredentialStepState();
}

class _AccountCredentialStepState extends State<AccountCredentialStep>
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

    _textSlide = Tween<Offset>(
      begin: const Offset(0, -0.8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0, 0.9, curve: Curves.easeOut),
      ),
    );
    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.1, 1, curve: Curves.easeOutCubic),
      ),
    );
    _buttonOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.4, 1, curve: Curves.easeIn),
      ),
    );

    if (widget.active) _playEntrance();
  }

  @override
  void didUpdateWidget(covariant AccountCredentialStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) _playEntrance();
  }

  void _playEntrance() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _contentController.reset();
      _irisController.forward(from: 0);
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
          Positioned(
            left: 0,
            bottom: -150,
            child: Transform.rotate(
              angle: -0.8,
              child: Image.asset(
                context.isDarkMode
                    ? AppAssets.ifLogoWhite
                    : AppAssets.ifLogoBlack,
                width: context.screenSize.width,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: context.extraPagePadding.copyWith(
                    top: 0,
                    bottom: 0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AuthBackButton(onTap: widget.onBack),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: context.extraPagePadding.copyWith(
                      top: context.headerTopSpacing,
                      bottom: keyboardHeight + 80,
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
                            child: AuthTextField(
                              controller: widget.controller,
                              focusNode: widget.focusNode,
                              hintText: widget.label,
                              keyboardType: widget.keyboardType,
                              isPassword: widget.isPassword,
                              textInputAction: widget.textInputAction,
                              onFieldSubmitted: (_) => widget.onNext(),
                            ),
                          ),
                        ),
                        AuthErrorBanner(error: widget.error),
                        if (widget.showPasswordStrength) ...[
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
                                  color: context.colors.onError.withValues(
                                    alpha: 0.45,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.15),
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              maintainBottomViewPadding: true,
              child: Padding(
                padding: context.extraPagePadding.copyWith(
                  top: 16,
                  bottom: 16,
                ),
                child: SlideTransition(
                  position: _buttonSlide,
                  child: FadeTransition(
                    opacity: _buttonOpacity,
                    child: Watch(
                      (_) {
                        final isLoading =
                            widget.isProcessing || widget.loading.value;

                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: AppActionButton(
                            text: widget.buttonText,
                            color: context.tertiary.withValues(alpha: 0.95),
                            foregroundColor: context.onTertiary,
                            isLoading: isLoading,
                            onPressed: isLoading ? null : widget.onNext,
                          ),
                        );
                      },
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
