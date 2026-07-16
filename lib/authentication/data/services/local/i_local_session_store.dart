import 'package:autth_injustice_app/domain/models/auth_entities.dart';

abstract class ILocalSessionStore {
  Future<void> save(SessionToken? token);
  Future<SessionToken?> read();
  Future<void> clear();
}
