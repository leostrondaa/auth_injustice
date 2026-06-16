import '../../core/typedefs/types_defs.dart';
import '../../domain/models/character_entity.dart';

/// Interface do repositório de Character.
///
/// O [uid] nunca é passado explicitamente pelos chamadores —
/// o repositório o resolve a partir da sessão ativa ([IAuthRepository]).
/// Os personagens são escopados por conta: `/accounts/{uid}/characters/{id}`.
abstract interface class ICharacterRepository {
  /// Gera um ID único para um novo personagem (via Firestore).
  String generateCharacterId();

  Future<CharacterResult> getCharacterById(String id);
  Future<ListCharacterResult> getAllCharacters();
  Future<CharacterResult> saveCharacter(Character character);
  Future<CharacterResult> updateCharacter(Character character);
  Future<CharacterResult> deleteCharacter(String id);
}
