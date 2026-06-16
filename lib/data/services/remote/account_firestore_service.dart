import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/failure/failure.dart';
import '../../../core/patterns/result.dart';
import '../../../core/typedefs/types_defs.dart';
import '../../../domain/models/account_entity.dart';
import '../../../domain/models/account_mapper.dart';
import 'account_remote_storage_interface.dart';

/// Implementação de [IAccountRemoteStorage] usando Cloud Firestore.
///
/// Cada conta é armazenada como um documento em `/accounts/{uid}`,
/// onde `uid` é o id do usuário no Firebase Auth.
final class AccountFirestoreService implements IAccountRemoteStorage {
  final FirebaseFirestore _firestore;

  AccountFirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _accountsRef =>
      _firestore.collection('accounts');

  @override
  Future<VoidResult> deleteAccount(String uid) async {
    try {
      await _accountsRef.doc(uid).delete();
      return Success(null);
    } catch (e) {
      return Error(
        ApiRemoteFailure('Firestore - Erro ao deletar conta: $e'),
      );
    }
  }

  @override
  Future<AccountResult> getAccount(String uid) async {
    try {
      final snapshot = await _accountsRef.doc(uid).get();

      if (!snapshot.exists || snapshot.data() == null) {
        return Error(EmptyResultFailure());
      }

      final account = AccountMapper.fromSnapshot(snapshot);
      return Success(account);
    } catch (e) {
      return Error(
        ApiRemoteFailure('Firestore - Erro ao obter conta: $e'),
      );
    }
  }

  @override
  Future<VoidResult> saveAccount(Account account) async {
    try {
      await _accountsRef
          .doc(account.uid)
          .set(AccountMapper.toMap(account));
      return Success(null);
    } catch (e) {
      return Error(
        ApiRemoteFailure('Firestore - Erro ao salvar conta: $e'),
      );
    }
  }

  @override
  Future<VoidResult> updateAccount(Account account) async {
    try {
      await _accountsRef
          .doc(account.uid)
          .update(AccountMapper.toMap(account));
      return Success(null);
    } catch (e) {
      return Error(
        ApiRemoteFailure('Firestore - Erro ao atualizar conta: $e'),
      );
    }
  }
}
