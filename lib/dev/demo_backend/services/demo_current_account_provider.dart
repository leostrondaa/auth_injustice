import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';

class DemoCurrentAccountProvider implements ICurrentAccountProvider {
  final DemoBackendStore _store;

  const DemoCurrentAccountProvider({
    required DemoBackendStore demoBackendStore,
  }) : _store = demoBackendStore;

  @override
  Account get currentAccount => _store.currentUser;

  @override
  String get currentUid => currentAccount.uid;
}
