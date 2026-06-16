import '../../core/typedefs/types_defs.dart';
import '../../domain/models/character_entity.dart';

/// A interface pública permanece igual à versão local: nenhum método
/// recebe `uid` explicitamente. O repositório resolve o uid internamente
/// a partir da sessão de autenticação ativa.
abstract interface class ICharacterRepository {
  /// Gera um novo id único para um personagem, a ser usado ao criar
  /// um [Character] antes de chamar [saveCharacter].
  String generateCharacterId();

  Future<CharacterResult> getCharacterById(String id);
  Future<ListCharacterResult> getAllCharacters();
  Future<CharacterResult> saveCharacter(Character character);
  Future<CharacterResult> updateCharacter(Character character);
  Future<CharacterResult> deleteCharacter(String id);
}
