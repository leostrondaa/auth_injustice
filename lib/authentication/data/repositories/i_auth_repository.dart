import 'package:autth_injustice_app/core/typedefs/types_defs.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../domain/models/auth_entities.dart';

/// Interface canônica do repositório de autenticação.
/// Existe apenas em `authentication/data/repositories/`.
///
/// O arquivo `data/repositories/i_auth_repository.dart` é apenas um
/// barrel re-export deste arquivo — não duplique a implementação.
abstract interface class IAuthRepository {
  AuthSession? get currentSession;
  Signal<AuthSession?> get sessionSignal;

  Future<AuthSessionResult> signIn(String email, String password);
  Future<AuthSessionResult> signInWithGoogle();
  Future<AuthSessionResult> signUp({
    String? name,
    required String email,
    required String password,
  });
  Future<VoidResult> signOut();
}
