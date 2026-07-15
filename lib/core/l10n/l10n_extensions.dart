import 'package:flutter/material.dart';
import 'package:autth_injustice_app/core/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  // Cria o atalho mágico .l10n para o BuildContext
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
