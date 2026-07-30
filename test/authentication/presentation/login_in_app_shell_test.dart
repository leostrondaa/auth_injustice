import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/app_shell/presentation/pages/app_shell_page.dart';
import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/presentation/pages/login_page.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/login/login_viewmodel.dart';
import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:autth_injustice_app/institution/presentation/institution_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('login fits inside the app shell on a narrow screen',
      (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    injector
      ..addInstance<LoginViewModel>(LoginViewModel(_FakeAuthFacade()))
      ..addInstance<AuthorizationService>(
        AuthorizationService(
          currentAccountProvider: _GuestAccountProvider(),
        ),
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
          child: const AppShellPage(
            currentIndex: 2,
            currentPath: '/login',
            child: LoginPage(returnTo: '/notifications'),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byIcon(Icons.notifications), findsOneWidget);
    expect(tester.takeException(), isNull);

    tester.view.viewInsets = const FakeViewPadding(bottom: 280);
    addTearDown(tester.view.resetViewInsets);
    await tester.pump();

    expect(find.byIcon(Icons.notifications), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

class _GuestAccountProvider implements ICurrentAccountProvider {
  @override
  Account? get currentAccount => null;

  @override
  String? get currentUid => null;
}

class _FakeAuthFacade implements IAuthUseCaseFacade {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
