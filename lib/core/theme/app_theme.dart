import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDesign {
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double hg = 48.0;

  static const double radiusMd = 20.0;
}

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => theme.colorScheme;
  TextTheme get text => theme.textTheme;

  TextStyle? get displayLarge => text.displayLarge;
  TextStyle? get displayMedium => text.displayMedium;
  TextStyle? get displaySmall => text.displaySmall;

  TextStyle? get headlineLarge => text.headlineLarge;
  TextStyle? get headlineMedium => text.headlineMedium;
  TextStyle? get headlineSmall => text.headlineSmall;

  TextStyle? get bodyLarge => text.bodyLarge;
  TextStyle? get bodyMedium => text.bodyMedium;
  TextStyle? get bodySmall => text.bodySmall;

  TextStyle? get titleLarge => text.titleLarge;

  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;

  double get spaceSm => AppDesign.sm;
  double get spaceMd => AppDesign.md;
  double get spaceLg => AppDesign.lg;

  // Backgrounds
  Color get background => theme.scaffoldBackgroundColor;
  Color get scaffoldBackground => theme.scaffoldBackgroundColor;
  Color get surface => colors.surface;

  // Principais cores
  Color get primary => colors.primary;
  Color get secondary => colors.secondary;
  Color get tertiary => colors.tertiary;

  // Cores "on"
  Color get onPrimary => colors.onPrimary;
  Color get onSecondary => colors.onSecondary;
  Color get onSurface => colors.onSurface;
  Color get onTertiary => colors.onTertiary;

  // Bordas
  double get radiusMd => AppDesign.radiusMd;

  EdgeInsets get pagePadding =>
      const EdgeInsets.symmetric(horizontal: 20);

  EdgeInsets get extraPagePadding =>
      const EdgeInsets.symmetric(horizontal: 27.0);

  Gradient get initialPageGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colors.primary,
          colors.secondary,
        ],
      );
}

TextTheme _buildCustomTextTheme(TextTheme baseTheme, TextTheme googleFontBase) {
  return googleFontBase.copyWith(
    // Títulos grandes e chamativos
    displayLarge: GoogleFonts.gasoekOne(
        textStyle: googleFontBase.displayLarge?.copyWith(fontSize: 8)),
    displayMedium:
        GoogleFonts.gasoekOne(textStyle: googleFontBase.displayMedium),
    displaySmall: GoogleFonts.inter(textStyle: googleFontBase.displaySmall),

    // Títulos principais de páginas
    headlineLarge: GoogleFonts.archivoBlack(
        textStyle: googleFontBase.headlineLarge?.copyWith(fontSize: 45)),

    headlineMedium: GoogleFonts.inter(
        fontSize: 22, textStyle: googleFontBase.headlineMedium),

    headlineSmall: GoogleFonts.inter(
        fontSize: 18, textStyle: googleFontBase.headlineSmall),

    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      textStyle: googleFontBase.bodyLarge,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      textStyle: googleFontBase.bodyMedium,
    ),
    bodySmall: GoogleFonts.inter(
      textStyle: googleFontBase.bodySmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    titleLarge: GoogleFonts.gasoekOne(textStyle: googleFontBase.titleLarge),
  );
}

/// TEMA CLARO: Roxo e Branco
ThemeData get lightTheme {
  final base = ThemeData.light();
  return base.copyWith(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 213, 62, 255),
      onPrimary: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1C1B1F),
      secondary: Color.fromARGB(255, 140, 52, 255),
      onSecondary: Color.fromARGB(255, 0, 0, 0),
      tertiary: Color.fromARGB(255, 255, 255, 255),
      onTertiary: Color.fromARGB(255, 0, 0, 0),
    ),

    scaffoldBackgroundColor: const Color(0xFFFFFFFF),

    // Usa Syne para a base e injeta Alfa Slab One nos títulos
    textTheme: _buildCustomTextTheme(
        base.textTheme, GoogleFonts.syneTextTheme(base.textTheme)),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Color(0xFF1C1B1F),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDesign.radiusMd)),
    ),
  );
}

/// TEMA ESCURO: Roxo e Preto
ThemeData get darkTheme {
  final base = ThemeData.dark();
  return base.copyWith(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 88, 0, 189),
      onPrimary: Color.fromARGB(255, 255, 255, 255),
      surface: Color(0xFF121212),
      onSurface: Color(0xFFFFFFFF),
      secondary: Color.fromARGB(255, 153, 29, 206),
      onSecondary: Color(0xFF000000),
      tertiary: Color.fromARGB(255, 0, 0, 0),
      onTertiary: Color.fromARGB(255, 255, 255, 255),
    ),

    scaffoldBackgroundColor: const Color(0xFF000000),

    // Usa Inter para a base e injeta Alfa Slab One nos títulos
    textTheme: _buildCustomTextTheme(
        base.textTheme, GoogleFonts.interTextTheme(base.textTheme)),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Color(0xFFFFFFFF),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDesign.radiusMd)),
    ),
  );
}
