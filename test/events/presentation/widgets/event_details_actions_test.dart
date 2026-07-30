import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/events/presentation/widgets/event_details/event_details_actions.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('guest sees only the map action', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: Scaffold(
          body: EventDetailsActions(
            authenticated: false,
            addedToPersonalHistory: false,
            personalRecordUpdating: false,
            onPersonalRecordTap: () {},
            onMapTap: () {},
            onExternalLinkTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Ver no mapa'), findsOneWidget);
    expect(find.text('Acessar link'), findsNothing);
    expect(find.text('Adicionar ao meu histórico'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
