import '../../../core/typedefs/types_defs.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';

abstract interface class IAccountRemoteStorage {
  Future<AccountResult> getAccount(String uid);
  Future<VoidResult> saveAccount(Account account);
  Future<VoidResult> updateAccount(Account account);
  Future<VoidResult> deleteAccount(String uid);
}
