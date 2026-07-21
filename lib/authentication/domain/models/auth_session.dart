import 'package:equatable/equatable.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';

// ──────────────────────────────────────────────
// Provider de autenticação
// ──────────────────────────────────────────────

enum AuthProvider { firebase, google }

// ──────────────────────────────────────────────
// Token de autenticação (em memória)
// ──────────────────────────────────────────────

class Token extends Equatable {
  final String value;
  final DateTime expiresAt;

  const Token({required this.value, required this.expiresAt});

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  List<Object?> get props => [value, expiresAt];
}

// ──────────────────────────────────────────────
// Token de sessão (persistido localmente via SharedPreferences)
// ──────────────────────────────────────────────

class SessionToken extends Equatable {
  final String uid;
  final String? displayName;
  final String? email;
  final String value;
  final DateTime expiresAt;
  final String? refreshToken;
  final AuthProvider provider;

  const SessionToken({
    required this.uid,
    this.displayName,
    this.email,
    required this.value,
    required this.expiresAt,
    this.refreshToken,
    required this.provider,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'displayName': displayName,
        'email': email,
        'value': value,
        'expiresAt': expiresAt.toIso8601String(),
        'refreshToken': refreshToken,
        'provider': provider.name,
      };

  factory SessionToken.fromJson(Map<String, dynamic> map) => SessionToken(
        uid: map['uid'] as String,
        displayName: map['displayName'] as String?,
        email: map['email'] as String?,
        value: map['value'] as String,
        expiresAt: DateTime.parse(map['expiresAt'] as String),
        refreshToken: map['refreshToken'] as String?,
        provider: AuthProvider.values.firstWhere(
          (e) => e.name == map['provider'],
          orElse: () => AuthProvider.firebase,
        ),
      );

  @override
  List<Object?> get props => [uid, value, expiresAt, provider];
}

// ──────────────────────────────────────────────
// Sessão autenticada — carrega Account completo do Firestore
// ──────────────────────────────────────────────

class AuthSession extends Equatable {
  final Account account;
  final Token token;

  const AuthSession({required this.account, required this.token});

  bool get isExpired => token.isExpired;

  @override
  List<Object?> get props => [account, token];
}
