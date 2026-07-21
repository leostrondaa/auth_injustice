import 'package:autth_injustice_app/authentication/data/services/remote/i_auth_service.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/l10n/locale_controller.dart';
import 'package:autth_injustice_app/core/navigation/app_router.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/core/theme/theme_controller.dart';
import 'package:autth_injustice_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals_flutter/signals_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupDependencies();

  final authService = injector.get<IAuthService>();
  await authService.initSession();

  final themeController = injector.get<ThemeController>();
  final localeController = injector.get<LocaleController>();

  runApp(
    Watch(
      (_) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Injustice App With Login',
        theme: app_theme.lightTheme,
        darkTheme: app_theme.darkTheme,
        themeMode: themeController.themeMode.value,
        routerConfig: AppRouter.router,
        builder: (context, child) {
          final media = MediaQuery.of(context);

          return MediaQuery(
            data: media.copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child!,
          );
        },
        locale: localeController.locale.value,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
}
