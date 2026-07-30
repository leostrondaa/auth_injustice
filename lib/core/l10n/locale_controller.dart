import 'package:autth_injustice_app/institution/domain/institution_package.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LocaleController {
  final InstitutionPackage _institutionPackage;

  final locale = signal<Locale?>(null);

  LocaleController({
    required InstitutionPackage institutionPackage,
  }) : _institutionPackage = institutionPackage;

  List<String> get supportedLanguageCodes =>
      _institutionPackage.localization.supportedLanguageCodes;

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
