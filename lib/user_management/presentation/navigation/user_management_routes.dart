import 'package:autth_injustice_app/core/navigation/app_transitions.dart';
import 'package:autth_injustice_app/user_management/presentation/pages/user_details_page.dart';
import 'package:autth_injustice_app/user_management/presentation/pages/user_management_page.dart';
import 'package:go_router/go_router.dart';

abstract final class UserManagementRouteNames {
  static const users = 'user-management';
  static const details = 'user-details';
}

abstract final class UserManagementPaths {
  static const users = '/users';
  static const detailsSegment = ':userId';
}

final userManagementRoute = GoRoute(
  path: UserManagementPaths.users,
  name: UserManagementRouteNames.users,
  pageBuilder: (context, state) => slidePage<void>(
    key: state.pageKey,
    child: const UserManagementPage(),
  ),
  routes: [
    GoRoute(
      path: UserManagementPaths.detailsSegment,
      name: UserManagementRouteNames.details,
      pageBuilder: (context, state) => slidePage<void>(
        key: state.pageKey,
        child: UserDetailsPage(
          userId: state.pathParameters['userId']!,
        ),
      ),
    ),
  ],
);
