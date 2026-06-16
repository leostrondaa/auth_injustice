import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/types_defs.dart';
import '../../authentication/data/repositories/i_auth_repository.dart';
import '../../data/services/remote/character_remote_storage_interface.dart';
import '../../domain/models/character_entity.dart';
import 'character_repository_interface.dart';

/// Implementação do repositório de Character.
///
/// O [uid] é sempre resolvido a partir da sessão de autenticação ativa,
/// escopando os personagens à conta logada: `/accounts/{uid}/characters`.
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

  String? get _currentUid => _authRepository.currentSession?.account.uid;

  UnauthenticatedFailure get _unauthError => UnauthenticatedFailure();

  @override
  String generateCharacterId() =>
      _firestore.collection('_ids').doc().id;

  @override
  Future<CharacterResult> getCharacterById(String id) async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthError);
    return _remoteStorage.getCharacterById(uid, id);
  }

  @override
  Future<ListCharacterResult> getAllCharacters() async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthError);
    return _remoteStorage.getAllCharacters(uid);
  }

  @override
  Future<CharacterResult> saveCharacter(Character character) async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthError);
    return _remoteStorage.saveCharacter(uid, character);
  }

  @override
  Future<CharacterResult> updateCharacter(Character character) async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthError);
    return _remoteStorage.updateCharacter(uid, character);
  }

  @override
  Future<CharacterResult> deleteCharacter(String id) async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthError);
    return _remoteStorage.deleteCharacter(uid, id);
  }
}
