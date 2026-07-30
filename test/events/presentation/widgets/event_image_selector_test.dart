import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/presentation/widgets/event_editor/event_image_selector.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_resource.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:autth_injustice_app/institution/presentation/institution_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('image catalog selects and expands on a narrow screen',
      (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    var draft = const EventEditorDraft();

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
              child: StatefulBuilder(
                builder: (context, setState) {
                  return EventImageSelector(
                    draft: draft,
                    onPickImage: () {},
                    onSelectPreset: (InstitutionResource image) {
                      setState(() {
                        draft = draft.copyWith(
                          selectedImageSource: image.location,
                        );
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('event-image-preset-0')), findsOneWidget);
    expect(find.byKey(const ValueKey('event-image-preset-6')), findsOneWidget);

    final collapsedHeight = tester
        .getSize(
          find.byKey(const ValueKey('event-image-catalog-viewport')),
        )
        .height;

    await tester.tap(
      find.byKey(const ValueKey('event-image-catalog-toggle')),
    );
    await tester.pumpAndSettle();

    final expandedHeight = tester
        .getSize(
          find.byKey(const ValueKey('event-image-catalog-viewport')),
        )
        .height;
    expect(expandedHeight, greaterThan(collapsedHeight));

    await tester.tap(
      find.byKey(const ValueKey('event-image-catalog-toggle')),
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(const ValueKey('event-image-preset-0')),
    );
    await tester.pumpAndSettle();

    expect(draft.selectedImageSource, contains('arts_culture.png'));
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(
      find.byKey(const ValueKey('event-image-expand-0')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Imagem selecionada'), findsOneWidget);
    expect(find.byIcon(Icons.close_rounded), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('image catalog shows three columns on a large screen',
      (tester) async {
    tester.view.physicalSize = const Size(700, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
              child: EventImageSelector(
                draft: const EventEditorDraft(),
                onPickImage: () {},
                onSelectPreset: (_) {},
              ),
            ),
          ),
        ),
      ),
    );

    final firstTop = tester
        .getTopLeft(find.byKey(const ValueKey('event-image-preset-0')))
        .dy;
    final thirdTop = tester
        .getTopLeft(find.byKey(const ValueKey('event-image-preset-2')))
        .dy;
    final fourthTop = tester
        .getTopLeft(find.byKey(const ValueKey('event-image-preset-3')))
        .dy;

    expect(thirdTop, firstTop);
    expect(fourthTop, greaterThan(firstTop));
    expect(tester.takeException(), isNull);
  });
}
