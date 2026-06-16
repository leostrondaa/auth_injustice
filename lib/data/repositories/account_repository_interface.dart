import '../../core/typedefs/types_defs.dart';
import '../../domain/models/account_entity.dart';

/// Interface do repositório de Account.
///
/// O [uid] nunca é passado explicitamente pelos chamadores —
/// o repositório o resolve a partir da sessão ativa ([IAuthRepository]).
abstract interface class IAccountRepository {
  Future<AccountResult> getAccount();
  Future<VoidResult> saveAccount(Account account);
  Future<VoidResult> updateAccount(Account account);
  Future<VoidResult> deleteAccount();
}
