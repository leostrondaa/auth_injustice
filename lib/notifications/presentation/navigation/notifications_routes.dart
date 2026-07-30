import 'package:autth_injustice_app/core/navigation/app_navigator_keys.dart';
import 'package:autth_injustice_app/core/navigation/app_transitions.dart';
import 'package:autth_injustice_app/notifications/presentation/pages/notification_editor_page.dart';
import 'package:autth_injustice_app/notifications/presentation/pages/notifications_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NotificationsRouteNames {
  static const notifications = 'notifications';
  static const create = 'notification-create';
}

class NotificationsPaths {
  static const notifications = '/notifications';
  static const create = '/notifications/create';
}

final notificationsRoute = GoRoute(
  path: NotificationsPaths.notifications,
  name: NotificationsRouteNames.notifications,
  pageBuilder: (context, state) => NoTransitionPage(
    key: ValueKey(state.uri.toString()),
    child: const NotificationsPage(),
  ),
  routes: [
    GoRoute(
      path: 'create',
      name: NotificationsRouteNames.create,
      parentNavigatorKey: AppNavigatorKeys.root,
      pageBuilder: (context, state) => slidePage<bool>(
        key: state.pageKey,
        child: const NotificationEditorPage(),
      ),
    ),
  ],
);
