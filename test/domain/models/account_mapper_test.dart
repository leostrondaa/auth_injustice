import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/account/data/mappers/account_firestore_mapper.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountFirestoreMapper', () {
    final account = Account(
      uid: 'account-id',
      email: 'student@ifpr.edu.br',
      displayName: 'Student',
      createdAt: DateTime(2026, 1, 10),
      updatedAt: DateTime(2026, 7, 21),
      isProfileConfigured: true,
      role: AccountRole.eventManager,
    );

    test('persists and restores the account role', () {
      final map = AccountFirestoreMapper.toMap(account);
      final restored = AccountFirestoreMapper.fromMap(map, uid: account.uid);

      expect(map['role'], AccountRole.eventManager.name);
      expect(restored.role, AccountRole.eventManager);
    });

    test('falls back to student for an unknown stored role', () {
      final map = AccountFirestoreMapper.toMap(account)
        ..['role'] = 'unknown-role';

      final restored = AccountFirestoreMapper.fromMap(map, uid: account.uid);

      expect(restored.role, AccountRole.student);
    });

    test('profile updates never include role or creation date', () {
      final update = AccountFirestoreMapper.toProfileUpdateMap(account);

      expect(update, isNot(contains('role')));
      expect(update, isNot(contains('createdAt')));
    });
  });
}
