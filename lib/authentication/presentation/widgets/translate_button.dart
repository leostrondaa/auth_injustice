import 'package:autth_injustice_app/main.dart';
import 'package:flutter/material.dart';

class TranslateButton extends StatelessWidget {
  const TranslateButton({super.key}); 

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      child: const Icon(Icons.translate, color: Colors.black),
      onPressed: () {
        final current = tempLocaleSignal.value?.languageCode;

        if (current == null || current == 'pt') {
          tempLocaleSignal.value = const Locale('en'); // Muda pra Inglês
        } else if (current == 'en') {
          tempLocaleSignal.value = const Locale('es'); // Muda pra Espanhol
        } else {
          tempLocaleSignal.value = const Locale('pt'); // Volta pra Português
        }
      },
    );
  }
}