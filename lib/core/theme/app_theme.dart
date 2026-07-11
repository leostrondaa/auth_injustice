import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDesign {
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;

  static const double radiusMd = 12.0;
}

extension ThemeContext on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}

TextTheme _buildCustomTextTheme(TextTheme baseTheme, TextTheme googleFontBase) {
  return googleFontBase.copyWith(
    // Títulos grandes e chamativos
    displayLarge:
        GoogleFonts.gasoekOne(textStyle: googleFontBase.displayLarge?.copyWith(fontSize: 8)),
    displayMedium:
        GoogleFonts.gasoekOne(textStyle: googleFontBase.displayMedium),
    displaySmall:
        GoogleFonts.chauPhilomeneOne(textStyle: googleFontBase.displaySmall),

    // Títulos principais de páginas
    headlineLarge:
        GoogleFonts.gasoekOne(textStyle: googleFontBase.headlineLarge?.copyWith(fontSize: 45)),
    headlineMedium:
        GoogleFonts.gasoekOne(textStyle: googleFontBase.headlineMedium),
    headlineSmall:
        GoogleFonts.gasoekOne(textStyle: googleFontBase.headlineSmall),

    // Títulos secundários de seções e sub-blocos
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
      primary: Color(0xFFa055da),
      onPrimary: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1C1B1F),
      secondary: Color(0xFF7159C1),
      onSecondary: Color(0xFFFFFFFF),
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
      primary: Color(0xFFBB86FC),
      onPrimary: Color(0xFF000000),
      surface: Color(0xFF121212),
      onSurface: Color(0xFFFFFFFF),
      secondary: Color(0xFF9871F5),
      onSecondary: Color(0xFF000000),
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
