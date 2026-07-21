import 'package:autth_injustice_app/core/typedefs/types_defs.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:autth_injustice_app/authentication/domain/models/auth_session.dart';

/// Contrato canônico da autenticação consumido pela camada de domínio.
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
