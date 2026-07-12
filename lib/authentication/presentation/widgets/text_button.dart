import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;

  const TextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
  });

  @override
  State<TextButton> createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        widget.color ?? Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () async {
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
            style: TextStyle(
              color:
                  _isPressed ? effectiveColor.withOpacity(0.5) : effectiveColor,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

class TextButtonRich extends StatefulWidget {
  final String baseText;
  final String actionText;
  final VoidCallback onTap;
  final Color? actionColor;
  final Color? baseColor;
  final double fontSize;

  const TextButtonRich({
    super.key,
    required this.baseText,
    required this.actionText,
    required this.onTap,
    this.actionColor,
    this.baseColor,
    this.fontSize = 14,
  });

  @override
  State<TextButtonRich> createState() => _TextButtonRichState();
}

class _TextButtonRichState extends State<TextButtonRich> {
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
    final actionColor =
        widget.actionColor ?? Theme.of(context).colorScheme.primary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: widget.baseText,
            style: TextStyle(
              color: widget.baseColor ?? const Color(0xFF757575),
              fontSize: widget.fontSize,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: widget.actionText,
                recognizer: _gestureRecognizer,
                style: TextStyle(
                  color:
                      _isPressed ? actionColor.withOpacity(0.5) : actionColor,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
