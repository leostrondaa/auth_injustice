import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:autth_injustice_app/events/presentation/widgets/event_editor/event_editor_sections.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_event_categories.dart';
import 'package:autth_injustice_app/institution/presentation/institution_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('review edit buttons target the responsible editor steps',
      (tester) async {
    tester.view.physicalSize = const Size(360, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final selectedSteps = <int>[];
    final startsAt = DateTime(2027, 3, 18, 14);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: InstitutionScope(
          package: const IfprPguaPackage(),
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: EventReviewSummary(
                draft: EventEditorDraft(
                  title: 'Mostra de projetos',
                  category: IfprPguaEventCategories.academic,
                  startsAt: startsAt,
                  endMode: EventEndMode.automatic,
                  endsAt: startsAt.add(const Duration(hours: 2)),
                  description: 'Projetos desenvolvidos no campus.',
                  externalUrl: 'https://ifpr.edu.br/eventos',
                  existingImageUrl: 'https://example.com/event.jpg',
                ),
                onEditStep: selectedSteps.add,
              ),
            ),
          ),
        ),
      ),
    );

    final editButtons = find.byIcon(Icons.edit_rounded);
    expect(editButtons, findsNWidgets(9));
    expect(find.text('Acadêmico'), findsOneWidget);
    expect(find.text('https://ifpr.edu.br/eventos'), findsOneWidget);

    await tester.tap(editButtons.first);
    await tester.pump();
    expect(selectedSteps, [6]);

    await tester.ensureVisible(editButtons.at(3));
    await tester.tap(editButtons.at(3));
    await tester.pump();
    expect(selectedSteps, [6, 1]);
    expect(tester.takeException(), isNull);
  });
}
