import 'package:autth_injustice_app/core/routes/auth_routes.dart';
import 'package:autth_injustice_app/core/routes/injustice_routes.dart';
import 'package:autth_injustice_app/domain/models/account_entity.dart';
import 'package:autth_injustice_app/domain/models/character_entity.dart';
import 'package:autth_injustice_app/presentation/views/about_view.dart';
import 'package:autth_injustice_app/presentation/views/account_create_view.dart';
import 'package:autth_injustice_app/presentation/views/characters/list_of/character_create_view.dart';
import 'package:autth_injustice_app/presentation/views/characters/list_of/character_edit_view.dart';
import 'package:autth_injustice_app/presentation/views/characters/list_of/characters_view.dart';
import 'package:autth_injustice_app/presentation/views/home_view.dart';
import 'package:autth_injustice_app/presentation/views/initial_view.dart';
import 'package:autth_injustice_app/under_construction_view.dart';
import 'package:go_router/go_router.dart';
import 'package:autth_injustice_app/authentication/presentation/controllers/auth_session_viewmodel.dart';
import '../di/dependency_injection.dart';

class GlobalRouteNames {
  static const underConstruction = 'under_construction';
  static const initial = 'initial';
  static const home = 'home';
  static const about = 'about';
  static const accountCreate = 'account_create';
  static const characters = 'characters';
  static const charactersEdit = 'charactersEdit';
  static const charactersCreate = 'charactersCreate';
}

class GlobalPaths {
  static const underConstruction = '/under-construction';
  static const initial = '/initial';
  static const home = '/home';
  static const about = '/about';
  static const accountCreate = '/account-create';
  static const characters = '/characters';
  static const charactersEdit = '/characters/edit';
  static const charactersCreate = '/characters/create';
}

class AppRouter {
  AppRouter._();

   static final GoRouter router = GoRouter(
    initialLocation: AuthPaths.splash,
    redirect: (context, state) {
      final authViewModel = injector.get<AuthViewModel>();
      final session = authViewModel.session.session.value;

      final currentPath = state.matchedLocation;

      final isAuthRoute = currentPath == AuthPaths.splash ||
          currentPath == AuthPaths.login ||
          currentPath == AuthPaths.register;

      final isAccountCreate = currentPath == GlobalPaths.accountCreate;

      if (session == null && !isAuthRoute) {
        return AuthPaths.login;
      }

      if (session != null && isAuthRoute) {
        if (!session.account.isProfileConfigured) {
          return GlobalPaths.accountCreate;
        }
        return GlobalPaths.home;
      }

      if (session != null &&
          !session.account.isProfileConfigured &&
          !isAccountCreate) {
        return GlobalPaths.accountCreate;
      }

      return null;
    },
    routes: <RouteBase>[
      ...authRoutes,
      ...appRoutes,
      GoRoute(
        path: GlobalPaths.underConstruction,
        name: GlobalRouteNames.underConstruction,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: UnderConstructionView()),
      ),
      GoRoute(
        path: GlobalPaths.initial,
        name: GlobalRouteNames.initial,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: InitialView()),
      ),
      GoRoute(
        path: GlobalPaths.home,
        name: GlobalRouteNames.home,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomeView()),
      ),
      GoRoute(
        path: GlobalPaths.accountCreate,
        name: GlobalRouteNames.accountCreate,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: AccountCreateView()),
      ),
      GoRoute(
        path: GlobalPaths.characters,
        name: GlobalRouteNames.characters,
        pageBuilder: (context, state) {
          final account = state.extra as Account;
          return NoTransitionPage(child: CharactersView(account: account));
        },
      ),
      GoRoute(
        name: GlobalRouteNames.charactersEdit,
        path: GlobalPaths.charactersEdit,
        builder: (context, state) {
          final extra =
              state.extra as ({Character character, Account account});
          return CharacterEditView(
            character: extra.character,
            account: extra.account,
          );
        },
      ),
      GoRoute(
        name: GlobalRouteNames.charactersCreate,
        path: GlobalPaths.charactersCreate,
        builder: (context, state) {
          final extra =
              state.extra as ({Account account, Character? character});
          return CharacterCreateView(
            account: extra.account,
            character: extra.character,
          );
        },
      ),
      GoRoute(
        path: GlobalPaths.about,
        name: GlobalRouteNames.about,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: AboutView()),
      ),
    ],
  );

  static bool _isNewAccount(Account account) {
    final fiveMinutesAgo = DateTime.now().subtract(const Duration(seconds: 10));
    return account.createdAt.isAfter(fiveMinutesAgo);
  }
}