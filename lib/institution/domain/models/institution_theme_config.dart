import 'package:flutter/material.dart';

@immutable
class InstitutionColorPalette {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Color tertiary;
  final Color onTertiary;
  final Color scaffoldBackground;
  final Color card;

  const InstitutionColorPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.tertiary,
    required this.onTertiary,
    required this.scaffoldBackground,
    required this.card,
  });
}

@immutable
class InstitutionThemeConfig {
  final InstitutionColorPalette light;
  final InstitutionColorPalette dark;

  const InstitutionThemeConfig({
    required this.light,
    required this.dark,
  });
}
