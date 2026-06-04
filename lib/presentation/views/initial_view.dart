import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_theme.dart';

/// Página de informações sobre o jogo
class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppSpacing.paddingLg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                height: AppSpacing.xxl), // Espaço para a barra de status
            Text(
              'Bem-vindoaa',
              style: context.textStyles.headlineMedium?.bold.withColor(
                Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: AppSpacing.sm),
            const Spacer(),

            const SizedBox(height: AppSpacing.lg),
            Center(
              child: ElevatedButton(
                onPressed: () => context.goNamed(GlobalRouteNames.home),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  'Continuar',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
