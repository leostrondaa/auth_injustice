import '../../core/typedefs/types_defs.dart';
import '../../domain/models/account_entity.dart';

/// A interface pública permanece igual à versão local: nenhum método
/// recebe `uid` explicitamente. O repositório resolve o uid internamente
/// a partir da sessão de autenticação ativa.
abstract interface class IAccountRepository {
  Future<AccountResult> getAccount();
  Future<VoidResult> saveAccount(Account account);
  Future<VoidResult> updateAccount(Account account);
  Future<VoidResult> deleteAccount();
}
