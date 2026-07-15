import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

enum PasswordStrength {
  empty(0.0, Colors.transparent),
  weak(0.25, Color.fromARGB(255, 255, 42, 45)),
  fair(0.5, Color.fromARGB(255, 255, 148, 17)),
  good(0.75, Color.fromARGB(255, 20, 197, 0)),
  strong(1.0, Color.fromARGB(255, 0, 190, 184));

  final double progress;
  final Color color;

  const PasswordStrength(this.progress, this.color);

  static PasswordStrength fromProgress(double progress) {
    if (progress <= 0.0) return PasswordStrength.empty;
    if (progress <= 0.25) return PasswordStrength.weak;
    if (progress <= 0.5) return PasswordStrength.fair;
    if (progress <= 0.75) return PasswordStrength.good;
    return PasswordStrength.strong;
  }

  String getMessage(BuildContext context) {
    switch (this) {
      case PasswordStrength.empty:
        return context.l10n.passwordStrengthEmpty;
      case PasswordStrength.weak:
        return context.l10n.passwordStrengthVeryWeak;
      case PasswordStrength.fair:
        return context.l10n.passwordStrengthFair;
      case PasswordStrength.good:
        return context.l10n.passwordStrengthGood;
      case PasswordStrength.strong:
        return context.l10n.passwordStrengthExcellent;
    }
  }
}

enum PasswordRequirementType {
  minLength,
  lowercaseAndUppercase,
  number,
  symbol;

  String getLabel(BuildContext context) {
    switch (this) {
      case PasswordRequirementType.minLength:
        return context.l10n.passwordMinLength;
      case PasswordRequirementType.lowercaseAndUppercase:
        return context.l10n.passwordRequireLowercaseAndUppercase;
      case PasswordRequirementType.number:
        return context.l10n.passwordRequireNumber;
      case PasswordRequirementType.symbol:
        return context.l10n.passwordRequireSymbol;
    }
  }
}

class PasswordIndicatorRequirement {
  final PasswordRequirementType type;
  final bool isMet;

  const PasswordIndicatorRequirement({
    required this.type,
    required this.isMet,
  });
}

class _PasswordAnalyzer {
  static final RegExp _hasUppercase = RegExp(r'[A-Z]');
  static final RegExp _hasLowercase = RegExp(r'[a-z]');
  static final RegExp _hasDigits = RegExp(r'[0-9]');
  static final RegExp _hasSpecial =
      RegExp(r'[!@#\$&*~•°^+=_\-`|\\(){}\[\]:;"<>,.?\/]');

  static Map<String, dynamic> check(String password) {
    if (password.isEmpty) {
      return {
        'strength': PasswordStrength.empty,
        'requirements': <PasswordIndicatorRequirement>[],
      };
    }

    final bool minLength = password.length >= 8;
    final bool uppercase = _hasUppercase.hasMatch(password);
    final bool lowercase = _hasLowercase.hasMatch(password);
    final bool digits = _hasDigits.hasMatch(password);
    final bool special = _hasSpecial.hasMatch(password);

    int score = 0;
    if (minLength) score++;
    if (uppercase && lowercase) score++;
    if (digits) score++;
    if (special) score++;

    final double calculatedProgress = score == 0 ? 0.1 : (score / 4.0);

    return {
      'strength': PasswordStrength.fromProgress(calculatedProgress),
      'requirements': [
        PasswordIndicatorRequirement(
          type: PasswordRequirementType.minLength,
          isMet: minLength,
        ),
        PasswordIndicatorRequirement(
          type: PasswordRequirementType.lowercaseAndUppercase,
          isMet: uppercase && lowercase,
        ),
        PasswordIndicatorRequirement(
          type: PasswordRequirementType.number,
          isMet: digits,
        ),
        PasswordIndicatorRequirement(
          type: PasswordRequirementType.symbol,
          isMet: special,
        ),
      ],
    };
  }
}

class PasswordStrengthIndicator extends StatelessWidget {
  final TextEditingController controller;

  const PasswordStrengthIndicator({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final analysis = _PasswordAnalyzer.check(value.text);
        final strength = analysis['strength'] as PasswordStrength;
        final requirements =
            analysis['requirements'] as List<PasswordIndicatorRequirement>;

        if (strength == PasswordStrength.empty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: (context.bodySmall ?? const TextStyle()).copyWith(
                    fontWeight: FontWeight.w600,
                    color: strength.color,
                    letterSpacing: -0.2,
                  ),
                  child: Text(strength.getMessage(context)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: _ProgressBarSegment(
                    index: index,
                    currentProgress: strength.progress,
                    targetColor: strength.color,
                    isDark: isDark,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            // Checklist
            ...requirements.map((req) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: _RequirementRow(
                  requirement: req,
                  isDark: isDark,
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _ProgressBarSegment extends StatelessWidget {
  final int index;
  final double currentProgress;
  final Color targetColor;
  final bool isDark;

  const _ProgressBarSegment({
    required this.index,
    required this.currentProgress,
    required this.targetColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color inactiveColor =
        isDark ? Colors.white10 : Colors.black.withOpacity(0.06);

    final double segmentFill = (currentProgress * 4.0 - index).clamp(0.0, 1.0);

    return Container(
      height: 5,
      margin: EdgeInsets.only(
        left: index == 0 ? 0 : 4,
        right: index == 3 ? 0 : 4,
      ),
      decoration: BoxDecoration(
        color: inactiveColor,
        borderRadius: BorderRadius.circular(100),
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          tween: Tween<double>(begin: 0, end: segmentFill),
          builder: (context, fillAmount, child) {
            return FractionallySizedBox(
              widthFactor: fillAmount,
              heightFactor: 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                color: targetColor,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final PasswordIndicatorRequirement requirement;
  final bool isDark;

  const _RequirementRow({
    required this.requirement,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final successColor = const Color(0xFF52C41A);
    final disabledColor = isDark ? Colors.white24 : Colors.black26;

    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.85, end: 1.0).animate(animation),
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: Icon(
            requirement.isMet
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            key: ValueKey<bool>(requirement.isMet),
            size: 16,
            color: requirement.isMet ? successColor : disabledColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: (context.bodySmall ?? const TextStyle()).copyWith(
              fontWeight: requirement.isMet ? FontWeight.w500 : FontWeight.w400,
              color: requirement.isMet
                  ? (isDark ? Colors.white : Colors.black87)
                  : disabledColor,
            ),
            child: Text(requirement.type.getLabel(context)),
          ),
        ),
      ],
    );
  }
}
