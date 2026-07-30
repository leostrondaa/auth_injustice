import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_seed.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('seed accounts remain data fixtures instead of startup roles', () {
    expect(DemoBackendSeed.studentAccount.role, AccountRole.student);
    expect(
      DemoBackendSeed.eventManagerAccount.role,
      AccountRole.eventManager,
    );
    expect(
      DemoBackendSeed.administratorAccount.role,
      AccountRole.administrator,
    );
  });
}
