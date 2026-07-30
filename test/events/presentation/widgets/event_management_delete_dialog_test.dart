import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/events/presentation/widgets/event_management/event_management_delete_dialog.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('unpublished event uses the compact confirmation dialog',
      (tester) async {
    EventRemovalDecision? decision;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: FilledButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => EventManagementDeleteDialog(
                    eventTitle: 'Evento futuro',
                    isPublished: false,
                    onCancel: () {},
                    onConfirm: (value) => decision = value,
                  ),
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(
      find.byKey(
        const ValueKey('app-confirmation-actions-horizontal'),
      ),
      findsOneWidget,
    );
    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();

    expect(decision, isNotNull);
    expect(decision?.isCancellation, isFalse);
  });

  testWidgets('published event requires a valid cancellation reason',
      (tester) async {
    EventRemovalDecision? decision;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: FilledButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => EventManagementDeleteDialog(
                    eventTitle: 'Festival de música',
                    isPublished: true,
                    onCancel: () {},
                    onConfirm: (value) => decision = value,
                  ),
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(
      find.text('Explique de forma clara por que o evento não acontecerá.'),
      findsOneWidget,
    );
    expect(find.textContaining('Evento cancelado:'), findsOneWidget);

    await tester.tap(find.text('Cancelar evento').last);
    await tester.pump();
    expect(decision, isNull);
    expect(
      find.text('Informe um motivo com pelo menos 10 caracteres.'),
      findsOneWidget,
    );

    await tester.enterText(
      find.byType(TextField),
      'O auditório ficará indisponível para manutenção.',
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Explique de forma clara por que o evento não acontecerá.'),
      findsNothing,
    );
    expect(
      find.text('Informe um motivo com pelo menos 10 caracteres.'),
      findsNothing,
    );

    await tester.tap(find.text('Cancelar evento').last);
    await tester.pump();

    expect(decision?.isCancellation, isTrue);
    expect(
      decision?.cancellationReason,
      'O auditório ficará indisponível para manutenção.',
    );
  });
}
