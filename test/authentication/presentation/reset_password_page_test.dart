import 'package:autth_injustice_app/authentication/domain/facades/i_password_reset_facade.dart';
import 'package:autth_injustice_app/authentication/presentation/navigation/password_reset_args.dart';
import 'package:autth_injustice_app/authentication/presentation/pages/reset_password_page.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/password_reset/password_reset_viewmodel.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:autth_injustice_app/institution/presentation/institution_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('password reset fits a narrow screen with the keyboard open',
      (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.view.viewInsets = const FakeViewPadding(bottom: 280);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);

    injector
      ..addInstance<PasswordResetViewModel>(
        PasswordResetViewModel(_FakePasswordResetFacade()),
      )
      ..commit();

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: InstitutionScope(
          package: const IfprPguaPackage(),
          child: const ResetPasswordPage(
            args: PasswordResetArgs(
              email: 'student@ifpr.edu.br',
              actionCode: 'authorized-code',
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(ResetPasswordPage), findsOneWidget);
    expect(find.text('Confirme a nova senha'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _FakePasswordResetFacade implements IPasswordResetFacade {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
