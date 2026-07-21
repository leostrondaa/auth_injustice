import 'package:autth_injustice_app/app_shell/presentation/pages/app_shell_page.dart';
import 'package:autth_injustice_app/authentication/presentation/navigation/auth_routes.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/navigation/complementary_hours_routes.dart';
import 'package:autth_injustice_app/events/presentation/navigation/events_routes.dart';
import 'package:autth_injustice_app/map/presentation/navigation/map_routes.dart';
import 'package:autth_injustice_app/notifications/presentation/navigation/notifications_routes.dart';
import 'package:autth_injustice_app/settings/presentation/navigation/settings_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static int _tabIndexFor(String path) {
    if (path.startsWith(EventsPaths.catalog)) return 1;
    if (path.startsWith(NotificationsPaths.notifications)) return 2;
    if (path.startsWith(ComplementaryHoursPaths.summary)) return 3;
    return 0;
  }

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AuthPaths.splash,
    routes: [
      ...authRoutes,
      ShellRoute(
        builder: (context, state, child) {
          final isSettingsFlow =
              state.uri.path.startsWith(SettingsPaths.settings);
          return AppShellPage(
            currentIndex: _tabIndexFor(state.uri.path),
            currentPath: state.uri.path,
            showNavigationBar: !isSettingsFlow,
            child: child,
          );
        },
        routes: [
          mapRoute,
          eventsRoute,
          notificationsRoute,
          complementaryHoursRoute,
        ],
      ),
    ],
  );
}
