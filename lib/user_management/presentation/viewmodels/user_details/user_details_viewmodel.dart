import 'package:autth_injustice_app/user_management/domain/facades/i_user_management_use_case_facade.dart';
import 'package:autth_injustice_app/user_management/presentation/commands/user_management_commands.dart';

import 'user_details_commands_viewmodel.dart';
import 'user_details_state_viewmodel.dart';

class UserDetailsViewModel {
  late final UserDetailsState _state;
  late final UserDetailsCommands _commands;

  UserDetailsState get state => _state;
  UserDetailsCommands get commands => _commands;

  UserDetailsViewModel(IUserManagementUseCaseFacade facade) {
    _state = UserDetailsState();
    _commands = UserDetailsCommands(
      state: _state,
      loadDetailsCommand: LoadManagedUserDetailsCommand(facade),
      updateRoleCommand: UpdateManagedUserRoleCommand(facade),
    );
  }
}
