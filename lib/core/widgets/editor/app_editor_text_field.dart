import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppEditorTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? helperText;
  final bool alwaysShowHint;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final int? maxLength;
  final bool autocorrect;
  final bool enableSuggestions;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const AppEditorTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.helperText,
    this.alwaysShowHint = false,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(14);
    final borderColor = context.onTertiary.withValues(alpha: 0.14);

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          maxLength: maxLength,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          cursorColor: context.primary,
          style: context.text.bodyLarge?.copyWith(
            color: context.onTertiary,
          ),
          decoration: InputDecoration(
            labelText: label.isEmpty ? null : label,
            hintText: value.text.isEmpty ? hintText : null,
            helperText: helperText,
            floatingLabelBehavior: alwaysShowHint
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.auto,
            alignLabelWithHint: maxLines > 1,
            filled: true,
            fillColor: context.onTertiary.withValues(
              alpha: context.isDarkMode ? 0.055 : 0.035,
            ),
            counterStyle: context.text.labelSmall?.copyWith(
              color: context.onTertiary.withValues(alpha: 0.45),
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
            labelStyle: context.text.bodyMedium?.copyWith(
              color: context.onTertiary.withValues(alpha: 0.60),
            ),
            hintStyle: context.text.bodyMedium?.copyWith(
              color: context.onTertiary.withValues(alpha: 0.38),
            ),
            helperStyle: context.text.labelSmall?.copyWith(
              color: context.onTertiary.withValues(alpha: 0.48),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: context.primary, width: 1.5),
            ),
          ),
        );
      },
    );
  }
}
