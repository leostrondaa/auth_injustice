import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextStyle? style;

  const AuthTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.style,
  });

  @override
  State<AuthTextButton> createState() => _AuthTextButtonState();
}

class _AuthTextButtonState extends State<AuthTextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? context.colors.primary;
    final defaultStyle = context.text.bodySmall ?? const TextStyle();
    final baseStyle = widget.style ?? defaultStyle;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTapUp: (_) async {
        setState(() => _isPressed = true);
        await Future.delayed(const Duration(milliseconds: 150));
        if (mounted) {
          setState(() => _isPressed = false);
          widget.onTap();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Text(
            widget.text,
            style: baseStyle.copyWith(
              color: _isPressed
                  ? effectiveColor.withValues(alpha: 0.5)
                  : effectiveColor,
              fontSize: widget.fontSize ?? baseStyle.fontSize,
              fontWeight: widget.fontWeight ?? baseStyle.fontWeight,
              letterSpacing: baseStyle.letterSpacing ?? 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

class AuthTextButtonRich extends StatefulWidget {
  final String baseText;
  final String actionText;
  final VoidCallback onTap;
  final Color? actionColor;
  final Color? baseColor;
  final double? fontSize;
  final TextStyle? style;

  const AuthTextButtonRich({
    super.key,
    required this.baseText,
    required this.actionText,
    required this.onTap,
    this.actionColor,
    this.baseColor,
    this.fontSize,
    this.style,
  });

  @override
  State<AuthTextButtonRich> createState() => _AuthTextButtonRichState();
}

class _AuthTextButtonRichState extends State<AuthTextButtonRich> {
  late final TapGestureRecognizer _gestureRecognizer;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _gestureRecognizer = TapGestureRecognizer()
      ..onTapDown = (_) {
        setState(() => _isPressed = true);
      }
      ..onTapCancel = () {
        setState(() => _isPressed = false);
      }
      ..onTap = () async {
        setState(() => _isPressed = true);
        await Future.delayed(const Duration(milliseconds: 150));

        if (mounted) {
          setState(() => _isPressed = false);
          widget.onTap();
        }
      };
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionColor = widget.actionColor ?? context.colors.primary;

    final defaultStyle = context.text.bodySmall ?? const TextStyle();
    final baseStyle = widget.style ?? defaultStyle;
    final effectiveFontSize = widget.fontSize ?? baseStyle.fontSize;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: '${widget.baseText} ',
            style: baseStyle.copyWith(
              color: widget.baseColor ?? const Color(0xFF757575),
              fontSize: effectiveFontSize,
              height: baseStyle.height ?? 1.4,
            ),
            children: [
              TextSpan(
                text: widget.actionText,
                recognizer: _gestureRecognizer,
                style: baseStyle.copyWith(
                  color: _isPressed
                      ? actionColor.withValues(alpha: 0.5)
                      : actionColor,
                  fontSize: effectiveFontSize,
                  fontWeight: widget.style?.fontWeight ?? FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
