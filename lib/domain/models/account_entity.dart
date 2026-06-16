import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String displayName;
  final int level;
  final int gold;
  final int gems;
  final int energy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Account({
    required this.uid,
    required this.name,
    required this.email,
    required this.displayName,
    required this.level,
    required this.gold,
    required this.gems,
    required this.energy,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Cria um Account novo (recém-registrado), com valores iniciais padrão.
  factory Account.initial({
    required String uid,
    required String email,
    required String name,
    required String displayName,
  }) {
    final now = DateTime.now();
    return Account(
      uid: uid,
      email: email,
      name: name,
      displayName: displayName,
      level: 1,
      gold: 0,
      gems: 0,
      energy: 100,
      createdAt: now,
      updatedAt: now,
    );
  }

  Account copyWith({
    String? uid,
    String? name,
    String? email,
    String? displayName,
    int? level,
    int? gold,
    int? gems,
    int? energy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      level: level ?? this.level,
      gold: gold ?? this.gold,
      gems: gems ?? this.gems,
      energy: energy ?? this.energy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        displayName,
        level,
        gold,
        gems,
        energy,
        createdAt,
        updatedAt,
      ];
}
