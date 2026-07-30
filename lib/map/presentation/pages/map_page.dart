import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/institution/presentation/institution_scope.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final map = context.institution.map;

    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Text(
          map.isConfigured
              ? context.l10n.mapLoading
              : context.l10n.mapComingSoon,
        ),
      ),
    );
  }
}
