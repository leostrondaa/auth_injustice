import 'package:autth_injustice_app/account/data/repositories/i_account_repository.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/account/domain/models/account_name.dart';
import 'package:autth_injustice_app/account/domain/usecases/account_usecases_impl.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeAccountRepository repository;
  late UpdateAccountNameUseCaseImpl useCase;

  setUp(() {
    repository = _FakeAccountRepository(
      Account(
        uid: 'student-id',
        email: 'student@ifpr.edu.br',
        displayName: 'Old Name',
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      ),
    );
    useCase = UpdateAccountNameUseCaseImpl(repository: repository);
  });

  test('updates only the current account profile name', () async {
    final result = await useCase(
        (name: AccountName(firstName: 'Ana', lastName: 'Silva'),));

    expect(result.isSuccess, isTrue);
    expect(repository.updatedAccount?.displayName, 'Ana Silva');
    expect(repository.updatedAccount?.uid, 'student-id');
  });

  test('rejects an incomplete name before accessing storage', () async {
    final result =
        await useCase((name: AccountName(firstName: 'Ana', lastName: ''),));

    expect(result.isFailure, isTrue);
    expect(result.failureValueOrNull?.msg, 'accountInvalidFullName');
    expect(repository.updatedAccount, isNull);
  });
}

class _FakeAccountRepository implements IAccountRepository {
  Account account;
  Account? updatedAccount;

  _FakeAccountRepository(this.account);

  @override
  Future<VoidResult> deleteAccount() async => const Success(null);

  @override
  Future<AccountResult> getAccount() async => Success(account);

  @override
  Future<VoidResult> saveAccount(Account account) async {
    this.account = account;
    return const Success(null);
  }

  @override
  Future<VoidResult> updateAccount(Account account) async {
    this.account = account;
    updatedAccount = account;
    return const Success(null);
  }
}
