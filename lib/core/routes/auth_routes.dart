import 'package:autth_injustice_app/authentication/presentation/pages/check_email_page.dart';
import 'package:autth_injustice_app/authentication/presentation/pages/login_page.dart';
import 'package:autth_injustice_app/authentication/presentation/pages/register_page.dart';
import 'package:autth_injustice_app/authentication/presentation/pages/initial_page.dart';
import 'package:autth_injustice_app/authentication/presentation/pages/splash_page.dart';
import 'package:autth_injustice_app/core/routes/custom_transitions.dart';
import 'package:autth_injustice_app/core/routes/route_args/check_email_args.dart';
import 'package:go_router/go_router.dart';

class AuthRouteNames {
  static const splash = 'splash';
  static const login = 'login';
  static const register = 'register';
  static const initial = 'initial';
  static const checkEmail = 'checkEmail';
}

class AuthPaths {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const initial = '/initial';
  static const checkEmail = '/checkEmail';
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
  GoRoute(
    path: AuthPaths.checkEmail,
    pageBuilder: (context, state) {
      final args = state.extra as CheckEmailArgs;

      return slidePage(
        key: state.pageKey,
        child: CheckEmailPage(args: args),
      );
    },
  ),
];
