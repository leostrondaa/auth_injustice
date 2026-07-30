import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/core/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('uses vertical actions on a narrow screen', (tester) async {
    await _setViewport(tester, const Size(320, 568));
    await _openDialog(tester);

    expect(
      find.byKey(const ValueKey('app-confirmation-actions-vertical')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('uses horizontal actions on a large screen', (tester) async {
    await _setViewport(tester, const Size(700, 900));
    await _openDialog(tester);

    expect(
      find.byKey(const ValueKey('app-confirmation-actions-horizontal')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('returns true from the confirmation action', (tester) async {
    await _setViewport(tester, const Size(320, 568));
    var confirmed = false;

    await _openDialog(
      tester,
      onResult: (value) => confirmed = value,
    );
    await tester.tap(find.text('Confirmar'));
    await tester.pumpAndSettle();

    expect(confirmed, isTrue);
  });
}

Future<void> _setViewport(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _openDialog(
  WidgetTester tester, {
  ValueChanged<bool>? onResult,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(
              child: FilledButton(
                onPressed: () async {
                  final result = await showAppConfirmationDialog(
                    context: context,
                    icon: Icons.warning_amber_rounded,
                    iconColor: Colors.orange,
                    title: 'Confirmar ação?',
                    message: 'Esta é uma mensagem de confirmação.',
                    cancelLabel: 'Cancelar',
                    cancelColor: Colors.grey,
                    confirmLabel: 'Confirmar',
                    confirmColor: Colors.red,
                    confirmForegroundColor: Colors.white,
                    confirmIcon: Icons.check_rounded,
                  );
                  onResult?.call(result);
                },
                child: const Text('Abrir'),
              ),
            );
          },
        ),
      ),
    ),
  );

  await tester.tap(find.text('Abrir'));
  await tester.pumpAndSettle();
}
