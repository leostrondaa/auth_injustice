import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const AppSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final scale = responsive.layoutScale;
    final textScale = responsive.textScale;
    final radius = BorderRadius.circular(16 * scale);
    final borderColor = context.onTertiary.withValues(alpha: 0.12);

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          autocorrect: false,
          onChanged: onChanged,
          cursorColor: context.primary,
          style: context.bodyMedium?.copyWith(
            color: context.onTertiary,
            fontSize: 14 * textScale,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: context.bodyMedium?.copyWith(
              color: context.onTertiary.withValues(alpha: 0.40),
              fontSize: 14 * textScale,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 21 * scale,
              color: context.onTertiary.withValues(alpha: 0.56),
            ),
            suffixIcon: value.text.isEmpty
                ? null
                : IconButton(
                    tooltip:
                        MaterialLocalizations.of(context).deleteButtonTooltip,
                    onPressed: () {
                      controller.clear();
                      onChanged?.call('');
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      size: 19 * scale,
                    ),
                    color: context.onTertiary.withValues(alpha: 0.56),
                  ),
            filled: true,
            fillColor: context.onTertiary.withValues(
              alpha: context.isDarkMode ? 0.055 : 0.035,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16 * scale,
              vertical: 15 * scale,
            ),
            border: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: context.primary, width: 1.5),
            ),
          ),
        );
      },
    );
  }
}
