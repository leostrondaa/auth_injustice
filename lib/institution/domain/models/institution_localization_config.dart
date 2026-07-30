import 'package:flutter/material.dart';

@immutable
class InstitutionLocalizationConfig {
  final String defaultLanguageCode;
  final List<String> supportedLanguageCodes;

  const InstitutionLocalizationConfig({
    required this.defaultLanguageCode,
    required this.supportedLanguageCodes,
  });

  List<Locale> resolveSupportedLocales(Iterable<Locale> appLocales) {
    final available = {
      for (final locale in appLocales) locale.languageCode: locale,
    };
    return List.unmodifiable(
      supportedLanguageCodes.map((code) => available[code]!),
    );
  }
}
