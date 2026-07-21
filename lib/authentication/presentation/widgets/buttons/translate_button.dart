import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/locale_controller.dart';
import 'package:flutter/material.dart';

class TranslateButton extends StatelessWidget {
  const TranslateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      onPressed: () {
        injector.get<LocaleController>().cycleLanguage(
              Localizations.localeOf(context).languageCode,
            );
      },
      child: const Icon(Icons.translate, color: Colors.black),
    );
  }
}
