import 'package:cloud_firestore/cloud_firestore.dart';

import 'account_entity.dart';

class AccountMapper {
  /// Converte uma [Account] em um Map adequado para o Firestore.
  ///
  /// O campo `uid` não é incluído no Map, pois ele é representado pelo
  /// ID do documento (`/accounts/{uid}`), evitando duplicação de dados.
  static Map<String, dynamic> toMap(Account account) {
    return {
      'name': account.name,
      'email': account.email,
      'displayName': account.displayName,
      'createdAt': Timestamp.fromDate(account.createdAt),
      'updatedAt': Timestamp.fromDate(account.updatedAt),
      'level': account.level,
      'gold': account.gold,
      'gems': account.gems,
      'energy': account.energy,
    };
  }

  /// Cria uma [Account] a partir do Map vindo do Firestore.
  ///
  /// O [uid] deve ser passado explicitamente (geralmente vindo de
  /// `documentSnapshot.id`), já que não é persistido dentro do documento.
  static Account fromMap(Map<String, dynamic> map, {required String uid}) {
    return Account(
      uid: uid,
      name: map['name'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      createdAt: _parseTimestamp(map['createdAt']),
      updatedAt: _parseTimestamp(map['updatedAt']),
      level: map['level'] as int,
      gold: (map['gold'] as num).toInt(),
      gems: map['gems'] as int,
      energy: map['energy'] as int,
    );
  }

  /// Cria uma [Account] diretamente a partir de um [DocumentSnapshot].
  static Account fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Documento de Account vazio para uid: ${snapshot.id}');
    }
    return fromMap(data, uid: snapshot.id);
  }

  static DateTime _parseTimestamp(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    throw ArgumentError('Formato de data inválido: $value');
  }
}
