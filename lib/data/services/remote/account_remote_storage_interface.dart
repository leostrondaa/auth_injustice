import '../../../core/typedefs/types_defs.dart';
import '../../../domain/models/account_entity.dart';

/// Fonte de dados remota para [Account], persistida no Firestore
/// em `/accounts/{uid}`.
abstract interface class IAccountRemoteStorage {
  Future<VoidResult> saveAccount(Account account);
  Future<VoidResult> updateAccount(Account account);
  Future<AccountResult> getAccount(String uid);
  Future<VoidResult> deleteAccount(String uid);
}
