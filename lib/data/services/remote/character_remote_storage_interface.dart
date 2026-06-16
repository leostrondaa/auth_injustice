import '../../../core/typedefs/types_defs.dart';
import '../../../domain/models/character_entity.dart';

/// Fonte de dados remota para [Character], persistida no Firestore
/// em `/accounts/{uid}/characters/{id}`.
abstract interface class ICharacterRemoteStorage {
  Future<CharacterResult> saveCharacter(String uid, Character character);
  Future<CharacterResult> updateCharacter(String uid, Character character);
  Future<ListCharacterResult> getAllCharacters(String uid);
  Future<CharacterResult> getCharacterById(String uid, String id);
  Future<CharacterResult> deleteCharacter(String uid, String id);
}
