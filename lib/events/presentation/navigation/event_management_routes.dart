import 'package:autth_injustice_app/core/navigation/app_transitions.dart';
import 'package:autth_injustice_app/core/navigation/app_navigator_keys.dart';
import 'package:autth_injustice_app/events/presentation/pages/event_editor_page.dart';
import 'package:autth_injustice_app/events/presentation/pages/event_management_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class EventManagementRouteNames {
  static const catalog = 'event-management';
  static const create = 'event-create';
  static const edit = 'event-edit';
}

class EventManagementPaths {
  static const catalog = '/event-management';
  static const create = '/event-management/create';
  static const edit = '/event-management/edit';
}

final eventManagementRoute = GoRoute(
  path: EventManagementPaths.catalog,
  name: EventManagementRouteNames.catalog,
  pageBuilder: (context, state) => NoTransitionPage(
    key: ValueKey(state.uri.toString()),
    child: const EventManagementPage(),
  ),
  routes: [
    GoRoute(
      path: 'create',
      name: EventManagementRouteNames.create,
      parentNavigatorKey: AppNavigatorKeys.root,
      pageBuilder: (context, state) => slidePage<bool>(
        key: state.pageKey,
        child: const EventEditorPage(),
      ),
    ),
    GoRoute(
      path: 'edit/:eventId',
      name: EventManagementRouteNames.edit,
      parentNavigatorKey: AppNavigatorKeys.root,
      pageBuilder: (context, state) => slidePage<bool>(
        key: state.pageKey,
        child: EventEditorPage(
          eventId: state.pathParameters['eventId']!,
        ),
      ),
    ),
  ],
);
