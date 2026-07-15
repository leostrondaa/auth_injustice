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
        Future<VoidResult> deleteAccount(String uid) {
          // TODO: implement deleteAccount
          throw UnimplementedError();
        }
      
        @override
        Future<AccountResult> getAccount(String uid) {
          // TODO: implement getAccount
          throw UnimplementedError();
        }
      
        @override
        Future<VoidResult> saveAccount(Account account) {
          // TODO: implement saveAccount
          throw UnimplementedError();
        }
      
        @override
        Future<VoidResult> updateAccount(Account account) {
          // TODO: implement updateAccount
          throw UnimplementedError();
        }

}
