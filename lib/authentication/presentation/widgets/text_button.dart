import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double fontSize;

  const TextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      splashColor:
          (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 6, horizontal: 4), // Boa área de toque
        child: Text(
          text,
          style: TextStyle(
            color: color ??
                Colors.grey.shade600, // Cor padrão caso não envie nenhuma
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

/// 2. Para textos mistos com apenas uma parte clicável (Ex: "Não tem uma conta? Sign Up")
class TextButtonRich extends StatefulWidget {
  final String baseText;
  final String actionText;
  final VoidCallback onTap;
  final Color? actionColor;
  final Color? baseColor;

  const TextButtonRich({
    super.key,
    required this.baseText,
    required this.actionText,
    required this.onTap,
    this.actionColor,
    this.baseColor,
  });

  @override
  State<TextButtonRich> createState() =>
      _TextButtonRichState();
}

class _TextButtonRichState extends State<TextButtonRich> {
  late final TapGestureRecognizer _gestureRecognizer;

  @override
  void initState() {
    super.initState();
    _gestureRecognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose(); // Evita Memory Leak internamente
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.baseText,
        style: TextStyle(
          color: widget.baseColor ?? const Color(0xFF757575),
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: widget.actionText,
            recognizer: _gestureRecognizer,
            style: TextStyle(
              color:
                  widget.actionColor ?? Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
