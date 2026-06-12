import '../../core/failure/failure.dart';
import '../../core/patterns/command.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/types_defs.dart';
import '../../domain/facades/character_facade_usecases_interface.dart';
import '../../domain/models/character_entity.dart';

final class CreateCharacterCommand
    extends ParameterizedCommand<Character, Failure, CharacterParams> {
  final ICharacterFacadeUseCases _characterFacadeUseCases;

  CreateCharacterCommand(this._characterFacadeUseCases);

  @override
  Future<CharacterResult> execute() async {
    final p = parameter;

    if (p == null) {
      return Error(InputFailure('Parametro nulo para criar personagem.'));
    }

    return await _characterFacadeUseCases.saveCharacter(p);
  }
}

final class DeleteCharacterCommand
    extends ParameterizedCommand<Character, Failure, CharacterIdParams> {
  final ICharacterFacadeUseCases _characterFacadeUseCases;

  DeleteCharacterCommand(this._characterFacadeUseCases);

  @override
  Future<CharacterResult> execute() async {
    final p = parameter;

    if (p == null) {
      return Error(InputFailure('Parametro nulo para deletar personagem.'));
    }
    
    if (p.id.isEmpty) {
      return Error(InputFailure('Parametro nulo para deletar personagem.'));
    }

    return await _characterFacadeUseCases.deleteCharacter(p);
  }
}

final class UpdateCharacterCommand
    extends ParameterizedCommand<Character, Failure, CharacterParams> {
  final ICharacterFacadeUseCases _characterFacadeUseCases;

  UpdateCharacterCommand(this._characterFacadeUseCases);

  @override
  Future<CharacterResult> execute() async {
    final p = parameter;

    if (p == null) {
      return Error(InputFailure('Parâmetro nulo.'));
    }
    
    return await _characterFacadeUseCases.updateCharacter(p);
  }
}

final class GetAllCharactersCommand
    extends ParameterizedCommand<List<Character>, Failure, NoParams> {
  final ICharacterFacadeUseCases _characterFacadeUseCases;

  GetAllCharactersCommand(this._characterFacadeUseCases);

  @override
  Future<ListCharacterResult> execute() async {
    return await _characterFacadeUseCases.getAllCharacters(());
  }
}

final class GetCharacterByIdCommand
    extends ParameterizedCommand<Character, Failure, CharacterIdParams> {
  final ICharacterFacadeUseCases _characterFacadeUseCases;

  GetCharacterByIdCommand(this._characterFacadeUseCases);

  @override
  Future<CharacterResult> execute() async {
    final p = parameter;

    if (p == null || p.id.isEmpty) {
      return Error(InputFailure('Parametro nulo para obter personagem por ID.'));
    }

    return await _characterFacadeUseCases.getCharacterById(p);
  }
}