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
  Future<CharacterResult> deleteCharacter(String uid, String id) async {
    try {
      final docRef = _charactersRef(uid).doc(id);
      final snapshot = await docRef.get();

      if (!snapshot.exists || snapshot.data() == null) {
        return Error(
          ApiRemoteFailure('Personagem com ID $id não encontrado'),
        );
      }

      final deletedCharacter = CharacterMapper.fromSnapshot(snapshot);
      await docRef.delete();

      return Success(deletedCharacter);
    } catch (e) {
      return Error(
        ApiRemoteFailure(
          'Firestore - Erro ao deletar personagem com id: $id ($e)',
        ),
      );
    }
  }

  @override
  Future<ListCharacterResult> getAllCharacters(String uid) async {
    try {
      final snapshot = await _charactersRef(uid).get();

      if (snapshot.docs.isEmpty) {
        return Error(EmptyResultFailure());
      }

      final characters =
          snapshot.docs.map((doc) => CharacterMapper.fromSnapshot(doc)).toList();

      return Success(characters);
    } catch (e) {
      return Error(
        ApiRemoteFailure('Firestore - Erro ao obter personagens: $e'),
      );
    }
  }

  @override
  Future<CharacterResult> getCharacterById(String uid, String id) async {
    try {
      final snapshot = await _charactersRef(uid).doc(id).get();

      if (!snapshot.exists || snapshot.data() == null) {
        return Error(
          ApiRemoteFailure('Personagem com ID $id não encontrado'),
        );
      }

      return Success(CharacterMapper.fromSnapshot(snapshot));
    } catch (e) {
      return Error(
        ApiRemoteFailure(
          'Firestore - Erro ao obter personagem com id: $id ($e)',
        ),
      );
    }
  }

  @override
  Future<CharacterResult> saveCharacter(
    String uid,
    Character character,
  ) async {
    try {
      await _charactersRef(uid)
          .doc(character.id)
          .set(CharacterMapper.toMap(character));

      return Success(character);
    } catch (e) {
      return Error(
        ApiRemoteFailure('Firestore - Erro ao salvar personagem: $e'),
      );
    }
  }

  @override
  Future<CharacterResult> updateCharacter(
    String uid,
    Character character,
  ) async {
    try {
      final docRef = _charactersRef(uid).doc(character.id);
      final snapshot = await docRef.get();

      if (!snapshot.exists) {
        return Error(
          ApiRemoteFailure(
            'Personagem não encontrado para atualização (ID: ${character.id})',
          ),
        );
      }

      await docRef.update(CharacterMapper.toMap(character));
      return Success(character);
    } catch (e) {
      return Error(ApiRemoteFailure('Erro ao editar personagem: $e'));
    }
  }
}
