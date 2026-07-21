import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LocaleController {
  static const supportedLanguageCodes = ['pt', 'en', 'es'];

  final locale = signal<Locale?>(null);

  void cycleLanguage(String currentLanguageCode) {
    final currentIndex = supportedLanguageCodes.indexOf(currentLanguageCode);
    final nextIndex = currentIndex < 0
        ? 0
        : (currentIndex + 1) % supportedLanguageCodes.length;

    locale.value = Locale(supportedLanguageCodes[nextIndex]);
  }

  void useSystemLocale() {
    locale.value = null;
  }
}
