import 'package:autth_injustice_app/core/navigation/app_transitions.dart';
import 'package:autth_injustice_app/events/presentation/pages/event_details_page.dart';
import 'package:autth_injustice_app/events/presentation/pages/events_catalog_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class EventsRouteNames {
  static const catalog = 'events-catalog';
  static const details = 'event-details';
}

class EventsPaths {
  static const catalog = '/events';
  static const details = '/events/:eventId';

  static String detailsFor(String eventId) => '/events/$eventId';
}

final eventsRoute = GoRoute(
  path: EventsPaths.catalog,
  name: EventsRouteNames.catalog,
  pageBuilder: (context, state) => NoTransitionPage(
    key: ValueKey(state.uri.toString()),
    child: const EventsCatalogPage(),
  ),
  routes: [
    GoRoute(
      path: ':eventId',
      name: EventsRouteNames.details,
      pageBuilder: (context, state) => slidePage(
        key: state.pageKey,
        child: EventDetailsPage(
          eventId: state.pathParameters['eventId']!,
        ),
      ),
    ),
  ],
);
