import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/types_defs.dart';
import 'character_repository_interface.dart';
import 'i_auth_repository.dart';
import '../services/remote/character_remote_storage_interface.dart';
import '../../domain/models/character_entity.dart';

/// Implementação do repositório de Character.
///
/// O `uid` utilizado nas operações é resolvido a partir da sessão de
/// autenticação ativa ([IAuthRepository.currentSession]), escopando todos
/// os personagens à conta logada (`/accounts/{uid}/characters`).
final class CharacterRepositoryImpl implements ICharacterRepository {
  final ICharacterRemoteStorage _remoteStorage;
  final IAuthRepository _authRepository;
  final FirebaseFirestore _firestore;

  CharacterRepositoryImpl({
    required ICharacterRemoteStorage remoteStorage,
    required IAuthRepository authRepository,
    FirebaseFirestore? firestore,
  })  : _remoteStorage = remoteStorage,
        _authRepository = authRepository,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// Resolve o uid da conta atualmente logada, ou null se não houver
  /// sessão ativa.
  String? get _currentUid => _authRepository.currentSession?.account.uid;

  /// Gera um novo id único do Firestore para ser usado ao criar um
  /// [Character] (antes de chamar [saveCharacter]).
  @override
  String generateCharacterId() {
    return _firestore.collection('_ids').doc().id;
  }

  @override
  Future<CharacterResult> updateCharacter(Character character) async {
    final uid = _currentUid;
    if (uid == null) {
      return Error(UnauthenticatedFailure());
    }
    return _remoteStorage.updateCharacter(uid, character);
  }

  @override
  Future<CharacterResult> deleteCharacter(String id) async {
    final uid = _currentUid;
    if (uid == null) {
      return Error(UnauthenticatedFailure());
    }
    return _remoteStorage.deleteCharacter(uid, id);
  }

  @override
  Future<CharacterResult> getCharacterById(String id) async {
    final uid = _currentUid;
    if (uid == null) {
      return Error(UnauthenticatedFailure());
    }
    return _remoteStorage.getCharacterById(uid, id);
  }

  @override
  Future<ListCharacterResult> getAllCharacters() async {
    final uid = _currentUid;
    if (uid == null) {
      return Error(UnauthenticatedFailure());
    }
    return _remoteStorage.getAllCharacters(uid);
  }

  @override
  Future<CharacterResult> saveCharacter(Character character) async {
    final uid = _currentUid;
    if (uid == null) {
      return Error(UnauthenticatedFailure());
    }
    return _remoteStorage.saveCharacter(uid, character);
  }
}
