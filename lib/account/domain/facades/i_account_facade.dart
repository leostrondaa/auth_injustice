import 'package:autth_injustice_app/core/typedefs/types_defs.dart';

abstract interface class IAccountFacade {
  Future<AccountResult> getAccount(NoParams params);
  Future<VoidResult> saveAccount(AccountParams params);
  Future<VoidResult> updateAccount(AccountParams params);
  Future<VoidResult> updateAccountName(UpdateAccountNameParams params);
  Future<VoidResult> deleteAccount(NoParams params);
}
