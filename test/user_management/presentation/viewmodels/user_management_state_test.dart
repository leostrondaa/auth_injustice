import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/user_management/domain/models/user_directory_entry.dart';
import 'package:autth_injustice_app/user_management/presentation/viewmodels/user_management_state_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserManagementState state;

  setUp(() {
    state = UserManagementState()
      ..setUsers([
        _entry(
          uid: 'student',
          name: 'Ana Silva',
          email: 'ana@ifpr.edu.br',
          role: AccountRole.student,
          totalMinutes: 120,
        ),
        _entry(
          uid: 'manager',
          name: 'Gestao Cultural',
          email: 'cultura@ifpr.edu.br',
          role: AccountRole.eventManager,
          totalMinutes: 30,
        ),
      ]);
  });

  test('filters the directory by role', () {
    state.selectRole(AccountRole.eventManager);

    expect(state.visibleUsers.map((user) => user.id), ['manager']);
  });

  test('searches by name or email without case sensitivity', () {
    state.setSearchQuery('ANA');
    expect(state.visibleUsers.single.id, 'student');

    state.setSearchQuery('cultura@');
    expect(state.visibleUsers.single.id, 'manager');
  });

  test('cycles through name and total-hours sorting modes', () {
    expect(state.sortMode.value, UserSortMode.nameAscending);
    expect(
      state.visibleUsers.map((user) => user.id),
      ['student', 'manager'],
    );

    state.cycleSortMode();
    expect(state.sortMode.value, UserSortMode.nameDescending);
    expect(
      state.visibleUsers.map((user) => user.id),
      ['manager', 'student'],
    );

    state.cycleSortMode();
    expect(state.sortMode.value, UserSortMode.hoursDescending);
    expect(
      state.visibleUsers.map((user) => user.id),
      ['student', 'manager'],
    );

    state.cycleSortMode();
    expect(state.sortMode.value, UserSortMode.hoursAscending);
    expect(
      state.visibleUsers.map((user) => user.id),
      ['manager', 'student'],
    );

    state.cycleSortMode();
    expect(state.sortMode.value, UserSortMode.nameAscending);
  });
}

UserDirectoryEntry _entry({
  required String uid,
  required String name,
  required String email,
  required AccountRole role,
  required int totalMinutes,
}) {
  return UserDirectoryEntry(
    account: Account(
      uid: uid,
      email: email,
      displayName: name,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
      role: role,
    ),
    totalComplementaryMinutes: totalMinutes,
  );
}
