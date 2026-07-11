import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ThemeController {
  // tema atual do aparelho
  final themeMode = signal<ThemeMode>(ThemeMode.system);

  void toggleTheme(BuildContext context) {
    if (themeMode.value == ThemeMode.system) {
      final isPlatformDark =
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.dark;
      themeMode.value = isPlatformDark ? ThemeMode.light : ThemeMode.dark;
    } else {
      themeMode.value =
          themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    }
  }
}
