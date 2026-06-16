import 'package:cloud_firestore/cloud_firestore.dart';
import 'account_entity.dart';

class AccountMapper {
  static Map<String, dynamic> toMap(Account account) {
    return {
      'email': account.email,
      'displayName': account.displayName,
      'nickname': account.nickname,
      'level': account.level,
      'gold': account.gold,
      'gems': account.gems,
      'energy': account.energy,
      'createdAt': Timestamp.fromDate(account.createdAt),
      'updatedAt': Timestamp.fromDate(account.updatedAt),
      'isProfileConfigured': account.isProfileConfigured,  
    };
  }

  static Account fromMap(Map<String, dynamic> map, {required String uid}) {
    return Account(
      uid: uid,
      email: map['email'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      nickname: map['nickname'] as String? ?? '',
      level: (map['level'] as num?)?.toInt() ?? 1,
      gold: (map['gold'] as num?)?.toInt() ?? 0,
      gems: (map['gems'] as num?)?.toInt() ?? 0,
      energy: (map['energy'] as num?)?.toInt() ?? 100,
      createdAt: _parseTimestamp(map['createdAt']),
      updatedAt: _parseTimestamp(map['updatedAt']),
      isProfileConfigured: map['isProfileConfigured'] as bool? ?? false, 
    );
  }

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
    return DateTime.now();
  }
}
