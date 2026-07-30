import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';

abstract final class AppDateTimePicker {
  static Future<DateTime?> pickDate({
    required BuildContext context,
    required DateTime? initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    return showDatePicker(
      context: context,
      confirmText: context.l10n.continueButton,
      cancelText: MaterialLocalizations.of(context).cancelButtonLabel,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: _buildDateTheme,
    );
  }

  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) {
    return showTimePicker(
      context: context,
      confirmText: context.l10n.continueButton,
      cancelText: MaterialLocalizations.of(context).cancelButtonLabel,
      initialTime: initialTime,
      builder: _buildTimeTheme,
    );
  }

  static Widget _buildDateTheme(BuildContext context, Widget? child) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final borderColor =
        isDark ? colors.onTertiary.withValues(alpha: 0.1) : Colors.transparent;

    return Theme(
      data: theme.copyWith(
        datePickerTheme: DatePickerThemeData(
          backgroundColor: colors.tertiary,
          surfaceTintColor: Colors.transparent,
          headerBackgroundColor: colors.onTertiary.withValues(alpha: 0.1),
          headerForegroundColor: colors.onTertiary,
          dividerColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: borderColor,
              width: isDark ? 1.5 : 1,
            ),
          ),
          headerHeadlineStyle: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
          headerHelpStyle: theme.textTheme.labelMedium?.copyWith(
            color: colors.tertiary.withValues(alpha: 0.72),
          ),
          weekdayStyle: theme.textTheme.labelMedium?.copyWith(
            color: colors.secondary.withValues(alpha: 0.55),
          ),
          dayStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w200,
          ),
          dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colors.secondary;
            }
            return Colors.transparent;
          }),
          dayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colors.onSecondary;
            }
            if (states.contains(WidgetState.disabled)) {
              return colors.onTertiary.withValues(alpha: 0.2);
            }
            return colors.onTertiary.withValues(alpha: 0.7);
          }),
          dayOverlayColor: WidgetStatePropertyAll(
            colors.secondary.withValues(alpha: 0.5),
          ),
          todayBorder: BorderSide(
            color: colors.secondary,
            width: 1.5,
          ),
          todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colors.secondary;
            }
            return Colors.transparent;
          }),
          todayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colors.onSecondary;
            }
            return colors.secondary;
          }),
          yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colors.secondary;
            }
            return Colors.transparent;
          }),
          yearForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colors.onSecondary;
            }
            return colors.onTertiary;
          }),
          cancelButtonStyle: _cancelButtonStyle(theme),
          confirmButtonStyle: _confirmButtonStyle(theme),
        ),
      ),
      child: child!,
    );
  }

  static Widget _buildTimeTheme(BuildContext context, Widget? child) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;
    final borderColor =
        isDark ? colors.onTertiary.withValues(alpha: 0.1) : Colors.transparent;

    return Theme(
      data: theme.copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: colors.tertiary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: borderColor,
              width: isDark ? 1.5 : 1,
            ),
          ),
          helpTextStyle: theme.textTheme.labelMedium?.copyWith(
            color: colors.onTertiary.withValues(alpha: 0.62),
            fontWeight: FontWeight.w700,
          ),
          hourMinuteColor: colors.onTertiary.withValues(alpha: 0.08),
          hourMinuteTextColor: colors.onTertiary,
          hourMinuteTextStyle: theme.textTheme.displayMedium?.copyWith(
            color: colors.onTertiary,
          ),
          dayPeriodColor: colors.secondary.withValues(alpha: 0.14),
          dayPeriodTextColor: colors.secondary,
          dayPeriodTextStyle: theme.textTheme.labelLarge,
          dayPeriodShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: colors.secondary.withValues(alpha: 0.32),
            ),
          ),
          dialBackgroundColor: colors.onTertiary.withValues(alpha: 0.07),
          dialHandColor: colors.secondary,
          dialTextColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colors.onSecondary;
            }
            return colors.onTertiary.withValues(alpha: 0.8);
          }),
          dialTextStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          cancelButtonStyle: _cancelButtonStyle(theme),
          confirmButtonStyle: _confirmButtonStyle(theme),
        ),
      ),
      child: child!,
    );
  }

  static ButtonStyle _cancelButtonStyle(ThemeData theme) {
    final colors = theme.colorScheme;

    return ButtonStyle(
      foregroundColor:
          WidgetStatePropertyAll(colors.onTertiary.withValues(alpha: 0.8)),
      overlayColor: WidgetStatePropertyAll(
        colors.secondary.withValues(alpha: 0.10),
      ),
      textStyle: WidgetStatePropertyAll(theme.textTheme.labelLarge),
    );
  }

  static ButtonStyle _confirmButtonStyle(ThemeData theme) {
    final colors = theme.colorScheme;

    return ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(colors.secondary),
      overlayColor: WidgetStatePropertyAll(
        colors.onSecondary.withValues(alpha: 0.12),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textStyle: WidgetStatePropertyAll(theme.textTheme.labelLarge),
    );
  }
}
