import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';

/// Identidade fixa usada apenas para visualizar perfis durante o desenvolvimento.
class DemoCurrentAccountProvider implements ICurrentAccountProvider {
  final Account account;

  const DemoCurrentAccountProvider(this.account);

  @override
  Account get currentAccount => account;

  @override
  String get currentUid => account.uid;
}
