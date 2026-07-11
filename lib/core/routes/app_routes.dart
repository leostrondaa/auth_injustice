import 'package:autth_injustice_app/core/routes/auth_routes.dart';
import 'package:autth_injustice_app/core/routes/injustice_routes.dart';
import 'package:autth_injustice_app/domain/models/account_entity.dart';
import 'package:autth_injustice_app/domain/models/character_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:autth_injustice_app/authentication/presentation/controllers/auth_session_viewmodel.dart';
import '../di/dependency_injection.dart';

class GlobalRouteNames {
  static const underConstruction = 'under_construction';
  static const home = 'home';
  static const about = 'about';
  static const accountCreate = 'account_create';
  static const characters = 'characters';
  static const charactersEdit = 'charactersEdit';
  static const charactersCreate = 'charactersCreate';
}

class GlobalPaths {
  static const underConstruction = '/under-construction';
  static const home = '/home';
  static const about = '/about';
  static const accountCreate = '/account-create';
  static const characters = '/characters';
  static const charactersEdit = '/characters/edit';
  static const charactersCreate = '/characters/create';
}

class AppRouter {
  AppRouter._();

  static final GoRouter router =
      GoRouter(initialLocation: AuthPaths.initial, routes: <RouteBase>[
    ...authRoutes,
    ...appRoutes,
  ]);
}
