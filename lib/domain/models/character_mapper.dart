import 'package:cloud_firestore/cloud_firestore.dart';

import 'character_entity.dart';

class CharacterMapper {
  /// Converte um [Character] em um Map adequado para o Firestore.
  ///
  /// O campo `id` não é incluído no Map, pois ele é representado pelo
  /// ID do documento na subcoleção `/accounts/{uid}/characters/{id}`.
  static Map<String, dynamic> toMap(Character character) {
    return {
      'name': character.name,
      'characterClass': character.characterClass.name,
      'rarity': character.rarity.name,
      'level': character.level,
      'threat': character.threat,
      'attack': character.attack,
      'health': character.health,
      'stars': character.stars,
      'alignment': character.alignment.name,
      'createdAt': Timestamp.fromDate(character.createdAt),
      'updatedAt': Timestamp.fromDate(character.updatedAt),
    };
  }

  /// Cria um [Character] a partir do Map vindo do Firestore.
  ///
  /// O [id] deve ser passado explicitamente (geralmente vindo de
  /// `documentSnapshot.id`), já que não é persistido dentro do documento.
  static Character fromMap(Map<String, dynamic> map, {required String id}) {
    return Character(
      id: id,
      name: map['name'] as String,
      characterClass:
          CharacterClass.values.byName(map['characterClass'] as String),
      rarity: CharacterRarity.values.byName(map['rarity'] as String),
      level: map['level'] as int,
      threat: map['threat'] as int,
      attack: map['attack'] as int,
      health: map['health'] as int,
      stars: map['stars'] as int,
      alignment: CharacterAlignment.values.byName(map['alignment'] as String),
      createdAt: _parseTimestamp(map['createdAt']),
      updatedAt: _parseTimestamp(map['updatedAt']),
    );
  }

  /// Cria um [Character] diretamente a partir de um [DocumentSnapshot].
  static Character fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Documento de Character vazio para id: ${snapshot.id}');
    }
    return fromMap(data, id: snapshot.id);
  }

  static DateTime _parseTimestamp(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    throw ArgumentError('Formato de data inválido: $value');
  }
}
