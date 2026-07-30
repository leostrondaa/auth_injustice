import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/core/widgets/animations/app_step_entrance_transition.dart';
import 'package:autth_injustice_app/core/widgets/editor/app_editor_step_scaffold.dart';
import 'package:autth_injustice_app/core/widgets/editor/app_editor_text_field.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('editor step fits a narrow portrait screen', (tester) async {
    tester.view.physicalSize = const Size(300, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final controller = TextEditingController();
    addTearDown(controller.dispose);
    var continued = false;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: Scaffold(
          body: AppEditorStepScaffold(
            active: true,
            step: 0,
            stepCount: 3,
            title: 'Escreva o aviso',
            subtitle: 'Inclua as informações necessárias.',
            buttonText: 'Continuar',
            loading: false,
            onBack: () {},
            onNext: () => continued = true,
            child: AppEditorTextField(
              controller: controller,
              label: 'Título',
              maxLength: 80,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Continuar'));
    await tester.pump(const Duration(milliseconds: 120));

    expect(continued, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('editor step replays the register entrance when reactivated',
      (tester) async {
    var active = true;
    late StateSetter updateHost;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: StatefulBuilder(
          builder: (context, setState) {
            updateHost = setState;
            return AppEditorStepScaffold(
              active: active,
              step: 0,
              stepCount: 2,
              title: 'Titulo animado',
              buttonText: 'Continuar',
              loading: false,
              onBack: () {},
              onNext: () {},
              child: const Text('Conteudo animado'),
            );
          },
        ),
      ),
    );

    final headerFade = find.descendant(
      of: find.byType(AppStepEntranceTransition).first,
      matching: find.byType(FadeTransition),
    );

    expect(
      tester.widget<FadeTransition>(headerFade).opacity.value,
      0,
    );

    await tester.pumpAndSettle();

    expect(
      tester.widget<FadeTransition>(headerFade).opacity.value,
      1,
    );

    updateHost(() => active = false);
    await tester.pump();
    updateHost(() => active = true);
    await tester.pump();

    expect(
      tester.widget<FadeTransition>(headerFade).opacity.value,
      0,
    );

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
