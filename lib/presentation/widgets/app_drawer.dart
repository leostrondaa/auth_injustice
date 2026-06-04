import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/dependency_injection.dart';
import '../../core/routes/app_routes.dart';
import '../../domain/models/account_entity.dart';
import '../controllers/account_viewmodel.dart';
import 'package:signals_flutter/signals_flutter.dart';


/// Drawer reutilizável para navegação entre páginas
class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final _vmAccount = injector.get<AccountViewModel>();

  @override
  Widget build(BuildContext context) {
    // Obter rota atual para destacar item selecionado
    final currentRoute = GoRouterState.of(context).uri.toString();

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.videogame_asset,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                const SizedBox(height: 8),
                Text(
                  'Injusce 2 Mobile',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              // color: currentRoute == AppRoutes.home
              color: currentRoute == GlobalPaths.home
                  ? Theme.of(context).colorScheme.primaryFixed
                  : Theme.of(context).colorScheme.onSecondary,
            ),
            title: Text(
              'Início',
              // style: currentRoute == AppRoutes.home
              style: currentRoute == GlobalPaths.home
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            selected: currentRoute == GlobalPaths.home,
            onTap: () {
              context.pop();
              if (currentRoute != GlobalPaths.home) {
                context.goNamed(GlobalRouteNames.home);
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_add,
              color: currentRoute == GlobalPaths.accountCreate
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSecondary,
            ),
            title: Watch(
              (_) => Text(
                _vmAccount.accountState.hasAccount.value
                    ? 'Editar Conta'
                    : 'Criar Conta',
                style: currentRoute == GlobalPaths.accountCreate
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
            ),
            selected: currentRoute == GlobalPaths.accountCreate,
            onTap: () {
              context.pop();
              if (currentRoute != GlobalPaths.accountCreate) {
                context.goNamed(GlobalRouteNames.accountCreate);
              }
            },
          ),
          Watch((_) {
            final hasAccount = _vmAccount.accountState.hasAccount.value;

            return ListTile(
              leading: Icon(
                Icons.people,
                color: !hasAccount
                    ? Colors.grey
                    : currentRoute == GlobalPaths.characters
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSecondary,
              ),
              title: Text(
                'Personagens',
                style: !hasAccount
                    ? const TextStyle(color: Colors.grey)
                    : currentRoute == GlobalPaths.characters
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
              selected: currentRoute == GlobalPaths.characters,
              onTap: hasAccount
                  ? () {
                      context.pop();

                      Account account = _vmAccount.accountState.state.value!;

                      if (currentRoute != GlobalPaths.characters) {
                        context.goNamed(
                          GlobalRouteNames.characters,
                          extra: account,
                        );
                      }
                    }
                  : null,
            );
          }),
          ListTile(
            leading: Icon(
              Icons.info,
              // color: Theme.of(context).colorScheme.onSecondary,
              color: currentRoute == GlobalPaths.about
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSecondary,
            ),
            title: Text(
              'Sobre',
              style: currentRoute == GlobalPaths.about
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            selected: currentRoute == GlobalPaths.about,
            onTap: () {
              context.pop();
              if (currentRoute != GlobalPaths.about) {
                context.goNamed(GlobalRouteNames.about);
              }
            },
          ),
        ],
      ),
    );
  }
}
