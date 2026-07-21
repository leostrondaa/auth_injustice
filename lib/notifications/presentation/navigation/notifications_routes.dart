import 'package:autth_injustice_app/notifications/presentation/pages/notifications_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NotificationsRouteNames {
  static const notifications = 'notifications';
}

class NotificationsPaths {
  static const notifications = '/notifications';
}

final notificationsRoute = GoRoute(
  path: NotificationsPaths.notifications,
  name: NotificationsRouteNames.notifications,
  pageBuilder: (context, state) => NoTransitionPage(
    key: ValueKey(state.uri.toString()),
    child: const NotificationsPage(),
  ),
);
