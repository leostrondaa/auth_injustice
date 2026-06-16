import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/failure/failure.dart';
import '../../../core/patterns/result.dart';
import '../../../core/typedefs/types_defs.dart';
import '../../../domain/models/account_entity.dart';
import '../../../domain/models/account_mapper.dart';
import 'account_remote_storage_interface.dart';

/// Implementação de [IAccountRemoteStorage] usando Cloud Firestore.
///
/// Estrutura no Firestore:
/// ```
/// /accounts/{uid}   ← documento com os dados da conta
/// ```
final class AccountFirestoreService implements IAccountRemoteStorage {
  final FirebaseFirestore _firestore;

  AccountFirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _accountDoc(String uid) =>
      _firestore.collection('accounts').doc(uid);

  @override
  Future<AccountResult> getAccount(String uid) async {
    try {
      final snapshot = await _accountDoc(uid).get();
      if (!snapshot.exists || snapshot.data() == null) {
        return Error(EmptyResultFailure());
      }
      return Success(AccountMapper.fromSnapshot(snapshot));
    } catch (e) {
      return Error(ApiRemoteFailure('Firestore - Erro ao obter conta: $e'));
    }
  }

  @override
  Future<VoidResult> saveAccount(Account account) async {
    try {
      await _accountDoc(account.uid).set(AccountMapper.toMap(account));
      return Success(null);
    } catch (e) {
      return Error(ApiRemoteFailure('Firestore - Erro ao salvar conta: $e'));
    }
  }

  @override
  Future<VoidResult> updateAccount(Account account) async {
    try {
      await _accountDoc(account.uid).update(AccountMapper.toMap(account));
      return Success(null);
    } catch (e) {
      return Error(ApiRemoteFailure('Firestore - Erro ao atualizar conta: $e'));
    }
  }

  @override
  Future<VoidResult> deleteAccount(String uid) async {
    try {
      await _accountDoc(uid).delete();
      return Success(null);
    } catch (e) {
      return Error(ApiRemoteFailure('Firestore - Erro ao deletar conta: $e'));
    }
  }
}
