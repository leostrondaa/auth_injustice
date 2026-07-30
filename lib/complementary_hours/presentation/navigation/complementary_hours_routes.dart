import 'package:autth_injustice_app/complementary_hours/presentation/pages/complementary_hours_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ComplementaryHoursRouteNames {
  static const summary = 'complementary-hours';
}

class ComplementaryHoursPaths {
  static const summary = '/complementary-hours';
}

final complementaryHoursRoute = GoRoute(
  path: ComplementaryHoursPaths.summary,
  name: ComplementaryHoursRouteNames.summary,
  pageBuilder: (context, state) => NoTransitionPage(
    key: ValueKey(state.uri.toString()),
    child: const ComplementaryHoursPage(),
  ),
);
