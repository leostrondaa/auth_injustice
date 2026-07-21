import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isProfileConfigured;
  final AccountRole role;

  const Account({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.createdAt,
    required this.updatedAt,
    this.isProfileConfigured = false,
    this.role = AccountRole.student,
  });

  factory Account.initial({
    required String uid,
    required String email,
    required String displayName,
  }) {
    final now = DateTime.now();
    return Account(
      uid: uid,
      email: email,
      displayName: displayName,
      createdAt: now,
      updatedAt: now,
      isProfileConfigured: false,
      role: AccountRole.student,
    );
  }

  bool get isProfileIncomplete => !isProfileConfigured;

  Account copyWith({
    String? uid,
    String? email,
    String? displayName,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isProfileConfigured,
    AccountRole? role,
  }) {
    return Account(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isProfileConfigured: isProfileConfigured ?? this.isProfileConfigured,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        createdAt,
        updatedAt,
        isProfileConfigured,
        role,
      ];
}
