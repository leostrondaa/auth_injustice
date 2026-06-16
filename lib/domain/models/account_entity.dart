import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String nickname;
  final int level;
  final int gold;
  final int gems;
  final int energy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isProfileConfigured; 

  const Account({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.nickname,
    required this.level,
    required this.gold,
    required this.gems,
    required this.energy,
    required this.createdAt,
    required this.updatedAt,
    this.isProfileConfigured = false, 
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
      nickname: '',
      level: 1,
      gold: 0,
      gems: 0,
      energy: 100,
      createdAt: now,
      updatedAt: now,
      isProfileConfigured: false, 
    );
  }

  bool get isProfileIncomplete => !isProfileConfigured;

  Account copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? nickname,
    int? level,
    int? gold,
    int? gems,
    int? energy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isProfileConfigured,
  }) {
    return Account(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      nickname: nickname ?? this.nickname,
      level: level ?? this.level,
      gold: gold ?? this.gold,
      gems: gems ?? this.gems,
      energy: energy ?? this.energy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isProfileConfigured: isProfileConfigured ?? this.isProfileConfigured,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        nickname,
        level,
        gold,
        gems,
        energy,
        createdAt,
        updatedAt,
        isProfileConfigured,
      ];
}