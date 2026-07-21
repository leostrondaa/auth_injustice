import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/failure/failure.dart';
import '../../../core/patterns/result.dart';
import '../../../core/typedefs/types_defs.dart';
import 'package:autth_injustice_app/account/data/mappers/account_firestore_mapper.dart';
import 'package:autth_injustice_app/account/data/services/i_account_remote_storage.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';

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
      if (!snapshot.exists) {
        return Error(NotFoundFailure('accountNotFound'));
      }

      return Success(AccountFirestoreMapper.fromSnapshot(snapshot));
    } on FirebaseException catch (error) {
      return Error(RemoteFailure(error.message ?? 'accountLoadError'));
    } catch (_) {
      return Error(RemoteFailure('accountLoadError'));
    }
  }

  @override
  Future<VoidResult> saveAccount(Account account) async {
    try {
      await _accountDoc(account.uid).set(AccountFirestoreMapper.toMap(account));
      return const Success(null);
    } on FirebaseException catch (error) {
      return Error(RemoteFailure(error.message ?? 'accountSaveError'));
    } catch (_) {
      return Error(RemoteFailure('accountSaveError'));
    }
  }

  @override
  Future<VoidResult> updateAccount(Account account) async {
    try {
      await _accountDoc(account.uid).update(
        AccountFirestoreMapper.toProfileUpdateMap(account),
      );
      return const Success(null);
    } on FirebaseException catch (error) {
      return Error(RemoteFailure(error.message ?? 'accountUpdateError'));
    } catch (_) {
      return Error(RemoteFailure('accountUpdateError'));
    }
  }

  @override
  Future<VoidResult> deleteAccount(String uid) async {
    try {
      await _accountDoc(uid).delete();
      return const Success(null);
    } on FirebaseException catch (error) {
      return Error(RemoteFailure(error.message ?? 'accountDeleteError'));
    } catch (_) {
      return Error(RemoteFailure('accountDeleteError'));
    }
  }
}
