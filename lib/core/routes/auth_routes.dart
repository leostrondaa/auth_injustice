import 'package:autth_injustice_app/authentication/presentation/pages/signin_page.dart';
import 'package:autth_injustice_app/authentication/presentation/pages/signup_page.dart';
import 'package:autth_injustice_app/authentication/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

class AuthRouteNames {
  static const splash = 'splash';
  static const login = 'login';
  static const register = 'register';
}

class AuthPaths {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
}

final List<RouteBase> authRoutes = [
  
  GoRoute(
    path: AuthPaths.splash,
    name: AuthRouteNames.splash,
    pageBuilder: (context, state) =>
        const NoTransitionPage(child: SplashPage()),
  ),
  GoRoute(
    path: AuthPaths.login,
    name: AuthRouteNames.login,
    pageBuilder: (context, state) => const NoTransitionPage(child: LoginPage()),
  ),
  GoRoute(
    path: AuthPaths.register,
    name: AuthRouteNames.register,
    pageBuilder: (context, state) =>
        const NoTransitionPage(child: SignupPage()),
  ),
];
