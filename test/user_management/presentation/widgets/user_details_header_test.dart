import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:autth_injustice_app/core/l10n/app_localizations.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart' as app_theme;
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:autth_injustice_app/user_management/domain/models/managed_user_details.dart';
import 'package:autth_injustice_app/user_management/domain/models/user_directory_entry.dart';
import 'package:autth_injustice_app/user_management/presentation/widgets/user_details/user_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('fixed user header fits a narrow portrait screen',
      (tester) async {
    tester.view.physicalSize = const Size(300, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final fadeProgress = ValueNotifier<double>(0);
    addTearDown(fadeProgress.dispose);

    final details = ManagedUserDetails(
      user: UserDirectoryEntry(
        account: Account(
          uid: 'student-id',
          email: 'ana.silva@ifpr.edu.br',
          displayName: 'Ana Maria da Silva',
          createdAt: DateTime(2026, 1, 1),
          updatedAt: DateTime(2026, 1, 1),
          isProfileConfigured: true,
          role: AccountRole.student,
        ),
        totalComplementaryMinutes: 3030,
      ),
      hoursSummary: const ComplementaryHoursSummary(
        completedMinutes: 3030,
        targetMinutes: 9000,
        milestoneMinutes: [0, 3000, 6000, 9000],
      ),
      records: const [],
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: app_theme.buildLightTheme(const IfprPguaPackage().theme),
        home: Scaffold(
          body: UserDetailsHeader(
            details: details,
            scale: 0.72,
            textScale: 0.84,
            horizontalPadding: 20,
            contentHeight: 245,
            fadeHeight: 42,
            fadeProgress: fadeProgress,
            promoting: false,
            demoting: false,
            onBack: () {},
            onPromote: () {},
            onDemote: null,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Ana Maria da Silva'), findsOneWidget);
    expect(find.text('Promover'), findsOneWidget);
    final promoteIcon = tester.widget<Icon>(
      find.byIcon(Icons.arrow_upward_rounded),
    );
    final demoteIcon = tester.widget<Icon>(
      find.byIcon(Icons.arrow_downward_rounded),
    );
    expect(demoteIcon.color!.a, lessThan(promoteIcon.color!.a));
    expect(tester.takeException(), isNull);
  });
}
