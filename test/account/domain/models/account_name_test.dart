import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/account/domain/models/account_name.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountName', () {
    test('normalizes whitespace and builds the stored display name', () {
      final name = AccountName(
        firstName: '  Ana  ',
        lastName: '  Maria   da Silva ',
      );

      expect(name.firstName, 'Ana');
      expect(name.lastName, 'Maria da Silva');
      expect(name.displayName, 'Ana Maria da Silva');
      expect(name.isComplete, isTrue);
    });

    test('restores first and last names from a display name', () {
      final name = AccountName.fromDisplayName('Ana Maria da Silva');

      expect(name.firstName, 'Ana');
      expect(name.lastName, 'Maria da Silva');
    });

    test('requires both first and last names', () {
      final name = AccountName(
        firstName: 'Ana',
        lastName: '',
      );

      expect(name.isComplete, isFalse);
    });
  });

  test('Account.copyWithName updates the profile without changing identity',
      () {
    final account = Account(
      uid: 'student-id',
      email: 'student@ifpr.edu.br',
      displayName: 'Old Name',
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    );

    final updated = account.copyWithName(
      AccountName(firstName: 'New', lastName: 'Name'),
    );

    expect(updated.uid, account.uid);
    expect(updated.email, account.email);
    expect(updated.displayName, 'New Name');
    expect(updated.isProfileConfigured, isTrue);
    expect(updated.updatedAt.isAfter(account.updatedAt), isTrue);
  });
}
