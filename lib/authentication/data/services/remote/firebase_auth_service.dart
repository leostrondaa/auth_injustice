import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';
import 'package:autth_injustice_app/account/data/services/i_account_remote_storage.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/authentication/domain/models/auth_session.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:autth_injustice_app/authentication/data/services/local/auth_local_session_manager.dart';

import 'i_auth_service.dart';

/// Serviço de autenticação com Firebase.
///
/// Responsabilidades:
/// - Autenticar o usuário via email/senha ou Google.
/// - Ao logar/registrar, garantir que o documento Account exista no Firestore.
/// - Manter o [AuthSession] reativo via Signal.
/// - Persistir o token localmente para restaurar sessão após restart.
class FirebaseAuthService implements IAuthService {
  final fb.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final AuthLocalSessionManager _localSession;
  final IAccountRemoteStorage _accountStorage;
  Future<void>? _googleInitialization;

  final Signal<AuthSession?> _currentSessionSignal = Signal<AuthSession?>(null);

  FirebaseAuthService({
    fb.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    required AuthLocalSessionManager localSession,
    required IAccountRemoteStorage accountStorage,
  })  : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance,
        _localSession = localSession,
        _accountStorage = accountStorage {
    // Escuta mudanças de estado do Firebase Auth (ex: token revogado externamente)
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  // ──────────────────────────────────────────────
  // Helpers internos
  // ──────────────────────────────────────────────

  /// Busca o Account no Firestore; se não existir, cria com dados iniciais.
  /// Isso garante que todo usuário autenticado tenha um documento `/accounts/{uid}`.
  Future<Account> _loadOrCreateAccount(fb.User fbUser) async {
    final result = await _accountStorage.getAccount(fbUser.uid);
    if (result case Success<Account, Failure>(:final value)) {
      return value;
    }

    final failure = result.failureValueOrNull;
    if (failure is! NotFoundFailure) {
      throw failure ?? RemoteFailure('accountLoadError');
    }

    // Documento não existe ainda: cria com valores padrão
    final initial = Account.initial(
      uid: fbUser.uid,
      email: fbUser.email ?? '',
      displayName: fbUser.displayName ?? '',
    );
    final saveResult = await _accountStorage.saveAccount(initial);
    if (saveResult case Error<void, Failure>(:final value)) {
      throw value;
    }
    return initial;
  }

  Future<AuthSession> _buildSession(fb.User fbUser) async {
    final account = await _loadOrCreateAccount(fbUser);
    final tokenResult = await fbUser.getIdTokenResult();
    final tokenStr = tokenResult.token ?? '';
    final tokenExp = tokenResult.expirationTime ??
        DateTime.now().add(const Duration(minutes: 50));
    return AuthSession(
      account: account,
      token: Token(value: tokenStr, expiresAt: tokenExp),
    );
  }

  Future<void> _persistSession(
    AuthSession session, {
    AuthProvider provider = AuthProvider.firebase,
  }) async {
    final sessionToken = SessionToken(
      uid: session.account.uid,
      displayName: session.account.displayName,
      email: session.account.email,
      value: session.token.value,
      expiresAt: session.token.expiresAt,
      refreshToken: null,
      provider: provider,
    );
    await _localSession.setToken(sessionToken);
    _currentSessionSignal.value = session;
  }

  // ──────────────────────────────────────────────
  // Listener do Firebase Auth
  // ──────────────────────────────────────────────

  void _onAuthStateChanged(fb.User? user) async {
    if (user == null) {
      _currentSessionSignal.value = null;
      return;
    }
    // Evita sobrescrever uma sessão já carregada (ex: vinda do initSession)
    if (_currentSessionSignal.value != null) return;

    try {
      final session = await _buildSession(user);
      await _persistSession(session);
    } catch (_) {
      _currentSessionSignal.value = null;
    }
  }

  Failure _mapAuthFailure(Object error) {
    if (error is Failure) return error;

    if (error is GoogleSignInException) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        return DefaultFailure('authGoogleCanceled');
      }
      return DefaultFailure('authUnexpectedError');
    }

    if (error is fb.FirebaseAuthException) {
      return switch (error.code) {
        'invalid-credential' ||
        'invalid-email' ||
        'user-not-found' ||
        'wrong-password' =>
          DefaultFailure('invalidFields'),
        'email-already-in-use' => DefaultFailure('authEmailAlreadyInUse'),
        'weak-password' => DefaultFailure('authWeakPassword'),
        'network-request-failed' => DefaultFailure('authNetworkError'),
        'too-many-requests' => DefaultFailure('authTooManyRequests'),
        'user-disabled' => DefaultFailure('authAccountDisabled'),
        _ => DefaultFailure('authUnexpectedError'),
      };
    }

    return DefaultFailure('authUnexpectedError');
  }

  Future<void> _initializeGoogleSignIn() {
    return _googleInitialization ??= _googleSignIn.initialize();
  }

  // ──────────────────────────────────────────────
  // Interface pública
  // ──────────────────────────────────────────────

  @override
  Signal<AuthSession?> get currentSessionSignal => _currentSessionSignal;

  @override
  AuthSession? get currentSession => _currentSessionSignal.value;

  @override
  Future<void> initSession() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      await _localSession.clear();
      _currentSessionSignal.value = null;
      return;
    }

    try {
      final session = await _buildSession(user);
      await _persistSession(session);
    } catch (_) {
      // Firebase remains the session authority. If Firestore is temporarily
      // unavailable, keep a least-privilege student account for this launch.
      final tokenResult = await user.getIdTokenResult();
      _currentSessionSignal.value = AuthSession(
        account: Account.initial(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
        ),
        token: Token(
          value: tokenResult.token ?? '',
          expiresAt: tokenResult.expirationTime ??
              DateTime.now().add(const Duration(minutes: 50)),
        ),
      );
    }
  }

  @override
  Future<AuthSessionResult> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) return Error(NotFoundFailure('authUserNotFound'));

      final session = await _buildSession(user);
      await _persistSession(session);
      return Success(session);
    } catch (error) {
      return Error(_mapAuthFailure(error));
    }
  }

  @override
  Future<AuthSessionResult> signInWithGoogle() async {
    try {
      await _initializeGoogleSignIn();
      final googleUser = await _googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;

      final credential = fb.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        return Error(DefaultFailure('authUnexpectedError'));
      }

      final session = await _buildSession(user);
      await _persistSession(session, provider: AuthProvider.google);
      return Success(session);
    } catch (error) {
      return Error(_mapAuthFailure(error));
    }
  }

  @override
  Future<AuthSessionResult> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) return Error(DefaultFailure('authUnexpectedError'));

      if (name != null && name.isNotEmpty) {
        await user.updateDisplayName(name);
        await user.reload();
      }

      final session = await _buildSession(_firebaseAuth.currentUser ?? user);
      await _persistSession(session);
      return Success(session);
    } catch (error) {
      return Error(_mapAuthFailure(error));
    }
  }

  @override
  Future<VoidResult> signOut() async {
    try {
      await _localSession.clear();
      await _firebaseAuth.signOut();
      try {
        final initialization = _googleInitialization;
        if (initialization != null) {
          await initialization;
          await _googleSignIn.signOut();
        }
      } catch (_) {
        // Firebase is already signed out; Google cleanup is best-effort.
      }
      _currentSessionSignal.value = null;
      return const Success(null);
    } catch (error) {
      return Error(_mapAuthFailure(error));
    }
  }
}
