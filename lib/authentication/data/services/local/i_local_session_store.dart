import 'package:autth_injustice_app/authentication/domain/models/auth_session.dart';

abstract class ILocalSessionStore {
  Future<void> save(SessionToken? token);
  Future<SessionToken?> read();
  Future<void> clear();
}
