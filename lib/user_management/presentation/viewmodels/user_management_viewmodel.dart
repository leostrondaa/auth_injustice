import 'package:autth_injustice_app/user_management/domain/facades/i_user_management_use_case_facade.dart';
import 'package:autth_injustice_app/user_management/presentation/commands/user_management_commands.dart';
import 'package:autth_injustice_app/user_management/presentation/viewmodels/user_management_commands_viewmodel.dart';
import 'package:autth_injustice_app/user_management/presentation/viewmodels/user_management_state_viewmodel.dart';

class UserManagementViewModel {
  late final UserManagementState _state;
  late final UserManagementCommands _commands;

  UserManagementState get state => _state;
  UserManagementCommands get commands => _commands;

  UserManagementViewModel(IUserManagementUseCaseFacade facade) {
    _state = UserManagementState();
    _commands = UserManagementCommands(
      state: _state,
      loadUsersCommand: LoadManagedUsersCommand(facade),
    );
  }
}
