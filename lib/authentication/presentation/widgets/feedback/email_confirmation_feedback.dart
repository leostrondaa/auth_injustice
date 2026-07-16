import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EmailConfirmationFeedback extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? footerText;

  const EmailConfirmationFeedback({
    super.key,
    required this.title,
    required this.subtitle,
    this.footerText,
  });

  @override
  State<EmailConfirmationFeedback> createState() =>
      _EmailConfirmationFeedbackState();
}

class _EmailConfirmationFeedbackState extends State<EmailConfirmationFeedback>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _pulseController;

  late final Animation<double> _badgeScale;
  late final Animation<double> _contentOpacity;
  late final Animation<Offset> _contentSlide;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _badgeScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0, 0.65, curve: Curves.easeOutBack),
      ),
    );

    _contentOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.35, 1, curve: Curves.easeOut),
      ),
    );

    _contentSlide =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.25, 1, curve: Curves.easeOutCubic),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _entryController.forward();
      _pulseController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = context.isVerySmallScreen;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.maxFormWidth),
        child: Padding(
          padding: context.extraPagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _badgeScale,
                child: _SuccessBadge(
                  pulse: _pulseController,
                  size: isCompact ? 112 : 132,
                ),
              ),
              SizedBox(height: isCompact ? 28 : 38),
              SlideTransition(
                position: _contentSlide,
                child: FadeTransition(
                  opacity: _contentOpacity,
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: context.text.headlineLarge?.copyWith(
                          color: context.colors.onTertiary,
                          fontSize: isCompact
                              ? context.text.headlineMedium?.fontSize
                              : context.text.headlineLarge?.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        widget.subtitle,
                        textAlign: TextAlign.center,
                        style: context.text.bodyLarge?.copyWith(
                          color:
                              context.colors.onTertiary.withValues(alpha: 0.68),
                          height: 1.5,
                          fontSize: isCompact
                              ? context.text.labelMedium?.fontSize
                              : context.text.labelLarge?.fontSize,
                          fontWeight: FontWeight.bold,
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

class _SuccessBadge extends StatelessWidget {
  final Animation<double> pulse;
  final double size;

  const _SuccessBadge({
    required this.pulse,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final secondary = context.colors.secondary;
    final onTertiary = context.colors.onTertiary;

    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) {
        final ringScale = 1 + pulse.value * 0.08;

        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: ringScale,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: onTertiary.withValues(alpha: 0.7),
                      width: 2,
                    ),
                  ),
                ),
              ),
              Container(
                width: size * 0.72,
                height: size * 0.72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: onTertiary,
                  boxShadow: [
                    BoxShadow(
                      color: secondary.withValues(alpha: 0.9),
                      blurRadius: 32,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: context.colors.tertiary,
                  size: size * 0.34,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
