import 'package:autth_injustice_app/account/domain/models/account.dart';

/// Fonte unica da identidade usada pelas features do aplicativo.
///
/// A implementacao deve refletir somente a sessao de autenticacao ativa.
abstract interface class ICurrentAccountProvider {
  Account? get currentAccount;

  String? get currentUid => currentAccount?.uid;
}
