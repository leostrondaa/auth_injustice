import 'package:autth_injustice_app/authentication/data/services/remote/i_auth_service.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/routes/app_routes.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/core/theme/theme_controller.dart';
import 'package:autth_injustice_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals_flutter/signals_flutter.dart';

// Um signal global provisório que começa como nulo (segue o sistema)
final tempLocaleSignal = signal<Locale?>(null);

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
              textScaler: const TextScaler.linear(1),
            ),
            child: child!,
          );
        },
        locale: tempLocaleSignal.value,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
}
