import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/events/presentation/widgets/event_editor/event_editor_sections.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('hours steppers fit and update on a narrow screen',
      (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    var hours = 0;
    var minutes = 0;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: StatefulBuilder(
              builder: (context, setState) {
                return EventHoursSelector(
                  enabled: true,
                  hours: hours,
                  minutes: minutes,
                  onEnabledChanged: (_) {},
                  onHoursChanged: (value) {
                    setState(() => hours = value);
                  },
                  onMinutesChanged: (value) {
                    setState(() => minutes = value);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add_rounded).first);
    await tester.pumpAndSettle();

    expect(hours, 1);

    await tester.tap(find.byIcon(Icons.add_rounded).last);
    await tester.pumpAndSettle();

    expect(hours, 1);
    expect(minutes, 5);
    expect(tester.takeException(), isNull);
  });
}
