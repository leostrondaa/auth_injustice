import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:autth_injustice_app/events/presentation/widgets/event_editor/event_editor_sections.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('event end selector fits a narrow portrait screen',
      (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: EventEndSelector(
              mode: EventEndMode.automatic,
              endsAt: DateTime(2026, 8, 12, 21),
              onModeChanged: (_) {},
              onPickDate: () {},
              onPickTime: () {},
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Horário definido'), findsOneWidget);
    expect(find.text('Encerramento manual'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
