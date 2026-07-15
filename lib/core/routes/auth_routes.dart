import 'package:autth_injustice_app/authentication/presentation/views/login_page.dart';
import 'package:autth_injustice_app/authentication/presentation/views/register_page.dart';
import 'package:autth_injustice_app/authentication/presentation/views/initial_page.dart';
import 'package:autth_injustice_app/authentication/presentation/views/splash_page.dart';
import 'package:autth_injustice_app/core/routes/custom_transitions.dart';
import 'package:go_router/go_router.dart';

class AuthRouteNames {
  static const splash = 'splash';
  static const login = 'login';
  static const register = 'register';
  static const initial = 'initial';
}

class AuthPaths {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const initial = '/initial';
}

final List<RouteBase> authRoutes = [
  GoRoute(
    path: AuthPaths.initial,
    name: AuthRouteNames.initial,
    pageBuilder: (context, state) =>
        const NoTransitionPage(child: InitialPage()),
  ),
  GoRoute(
    path: AuthPaths.login,
    name: AuthRouteNames.login,
    pageBuilder: (context, state) => const NoTransitionPage(child: LoginPage()),
  ),
  GoRoute(
    path: AuthPaths.register,
    pageBuilder: (context, state) => slidePage(
      key: state.pageKey,
      child: const RegisterPage(),
    ),
  ),
  GoRoute(
    path: AuthPaths.splash,
    name: AuthRouteNames.splash,
    pageBuilder: (context, state) =>
        const NoTransitionPage(child: SplashPage()),
  ),
];
