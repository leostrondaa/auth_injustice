import 'character_entity.dart';

class CharacterMapper {
  // O método que o Dart diz que sumiu está aqui:
  static Map<String, dynamic> toMap(Character character) {
    return {
      'id': character.id,
      'name': character.name,
      'characterClass': character.characterClass.name,
      'rarity': character.rarity.name,
      'level': character.level,
      'threat': character.threat,
      'attack': character.attack,
      'health': character.health,
      'stars': character.stars,
      'alignment': character.alignment.name,
      'createdAt': character.createdAt.toIso8601String(),
      'updatedAt': character.updatedAt.toIso8601String(),
    };
  }

  static Character fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Desconhecido',
      characterClass: _parseEnum(CharacterClass.values, map['characterClass'], CharacterClass.values.first),
      rarity: _parseEnum(CharacterRarity.values, map['rarity'], CharacterRarity.values.first),
      level: map['level'] as int? ?? 1,
      threat: map['threat'] as int? ?? 0,
      attack: map['attack'] as int? ?? 0,
      health: map['health'] as int? ?? 100,
      stars: map['stars'] as int? ?? 1,
      alignment: _parseEnum(CharacterAlignment.values, map['alignment'], CharacterAlignment.values.first),
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'] as String) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt'] as String) : DateTime.now(),
    );
  }

  static T _parseEnum<T extends Enum>(List<T> values, dynamic value, T fallback) {
    if (value == null) return fallback;
    try {
      return values.byName(value as String);
    } catch (_) {
      return fallback; 
    }
  }
}