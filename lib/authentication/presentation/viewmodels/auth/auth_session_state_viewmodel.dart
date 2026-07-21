import 'package:signals_flutter/signals_flutter.dart';

import 'package:autth_injustice_app/authentication/domain/models/auth_session.dart';

enum AuthStatus {
  unauthenticated,
  authenticated,
  expired,
}

class AuthSessionState {
  final status = signal<AuthStatus>(AuthStatus.unauthenticated);
  final session = signal<AuthSession?>(null);
  final message = signal<String?>(null);

  bool get isAuthenticated =>
      status.value == AuthStatus.authenticated &&
      session.value != null &&
      !session.value!.isExpired;

  bool get isExpired => status.value == AuthStatus.expired;

  void setAuthenticated(AuthSession authSession) {
    session.value = authSession;
    status.value = AuthStatus.authenticated;
    message.value = null;
  }

  void setUnauthenticated({String? msg}) {
    session.value = null;
    status.value = AuthStatus.unauthenticated;
    message.value = msg;
  }

  void setExpired({String? msg}) {
    session.value = null;
    status.value = AuthStatus.expired;
    message.value = msg ?? 'Sessão expirada';
  }

  void clearMessage() {
    message.value = null;
  }

  void setMessage(String msg) {
    message.value = msg;
  }
}
