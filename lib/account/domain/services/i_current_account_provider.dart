import 'package:autth_injustice_app/account/domain/models/account.dart';

/// Único ponto de acesso à identidade usada pelas features do aplicativo.
///
/// Durante o desenvolvimento, a implementação vem do backend demo. Em
/// produção, ela deve refletir exclusivamente a sessão autenticada.
abstract interface class ICurrentAccountProvider {
  Account? get currentAccount;

  String? get currentUid => currentAccount?.uid;
}
