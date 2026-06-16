import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';
import 'package:autth_injustice_app/domain/models/account_entity.dart';
import 'package:autth_injustice_app/domain/models/auth_entities.dart';
import 'package:autth_injustice_app/data/services/remote/account_remote_storage_interface.dart';
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
  final AuthLocalSessionManager _localSession;
  final IAccountRemoteStorage _accountStorage;

  final Signal<AuthSession?> _currentSessionSignal = Signal<AuthSession?>(null);

  FirebaseAuthService({
    fb.FirebaseAuth? firebaseAuth,
    required AuthLocalSessionManager localSession,
    required IAccountRemoteStorage accountStorage,
  })  : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance,
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
    // Documento não existe ainda: cria com valores padrão
    final initial = Account.initial(
      uid: fbUser.uid,
      email: fbUser.email ?? '',
      displayName: fbUser.displayName ?? '',
    );
    await _accountStorage.saveAccount(initial);
    return initial;
  }

  Future<AuthSession> _buildSession(fb.User fbUser) async {
    final account = await _loadOrCreateAccount(fbUser);
    final tokenStr = await fbUser.getIdToken() ?? '';
    final tokenExp = DateTime.now().add(const Duration(hours: 1));
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

    final session = await _buildSession(user);
    await _persistSession(session);
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
    final token = await _localSession.getValidToken();
    if (token == null) return;

    // Tenta carregar o Account atualizado do Firestore
    final result = await _accountStorage.getAccount(token.uid);
    final Account account;
    if (result case Success<Account, Failure>(:final value)) {
      account = value;
    } else {
      // Fallback com dados mínimos do token local
      account = Account.initial(
        uid: token.uid,
        email: token.email ?? '',
        displayName: token.displayName ?? '',
      );
    }

    _currentSessionSignal.value = AuthSession(
      account: account,
      token: Token(value: token.value, expiresAt: token.expiresAt),
    );
  }

  @override
  Future<AuthSessionResult> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) return Error(DefaultFailure('Usuário não encontrado'));

      final session = await _buildSession(user);
      await _persistSession(session);
      return Success(session);
    } catch (e) {
      return Error(DefaultFailure(e.toString()));
    }
  }

  @override
  Future<AuthSessionResult> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;

      final credential = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        return Error(DefaultFailure('Falha ao autenticar com o Google.'));
      }

      final session = await _buildSession(user);
      await _persistSession(session, provider: AuthProvider.google);
      return Success(session);
    } catch (e) {
      return Error(DefaultFailure(e.toString()));
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
      if (user == null) return Error(DefaultFailure('Falha ao criar usuário'));

      if (name != null && name.isNotEmpty) {
        await user.updateDisplayName(name);
        await user.reload();
      }

      final session = await _buildSession(_firebaseAuth.currentUser ?? user);
      await _persistSession(session);
      return Success(session);
    } catch (e) {
      return Error(DefaultFailure(e.toString()));
    }
  }

  @override
  Future<VoidResult> signOut() async {
    await _localSession.clear();
    await _firebaseAuth.signOut();
    _currentSessionSignal.value = null;
    return Success(null);
  }
}
