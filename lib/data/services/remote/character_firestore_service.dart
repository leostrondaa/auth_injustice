import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/failure/failure.dart';
import '../../../core/patterns/result.dart';
import '../../../core/typedefs/types_defs.dart';
import '../../../domain/models/character_entity.dart';
import '../../../domain/models/character_mapper.dart';
import 'character_remote_storage_interface.dart';

/// Implementação de [ICharacterRemoteStorage] usando Cloud Firestore.
///
/// Cada personagem é armazenado como um documento na subcoleção
/// `/accounts/{uid}/characters/{id}`, escopando os personagens por conta.
final class CharacterFirestoreService implements ICharacterRemoteStorage {
  final FirebaseFirestore _firestore;

  CharacterFirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _charactersRef(String uid) =>
      _firestore.collection('accounts').doc(uid).collection('characters');
      
        @override
        Future<CharacterResult> deleteCharacter(String uid, String id) {
          // TODO: implement deleteCharacter
          throw UnimplementedError();
        }
      
        @override
        Future<ListCharacterResult> getAllCharacters(String uid) {
          // TODO: implement getAllCharacters
          throw UnimplementedError();
        }
      
        @override
        Future<CharacterResult> getCharacterById(String uid, String id) {
          // TODO: implement getCharacterById
          throw UnimplementedError();
        }
      
        @override
        Future<CharacterResult> saveCharacter(String uid, Character character) {
          // TODO: implement saveCharacter
          throw UnimplementedError();
        }
      
        @override
        Future<CharacterResult> updateCharacter(String uid, Character character) {
          // TODO: implement updateCharacter
          throw UnimplementedError();
        }

}
