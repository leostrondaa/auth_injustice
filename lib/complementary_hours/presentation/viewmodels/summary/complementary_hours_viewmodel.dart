import 'package:autth_injustice_app/complementary_hours/domain/facades/i_complementary_hours_use_case_facade.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/commands/complementary_hours_commands.dart';

import 'complementary_hours_commands_viewmodel.dart';
import 'complementary_hours_state_viewmodel.dart';

class ComplementaryHoursViewModel {
  late final ComplementaryHoursState _state;
  late final ComplementaryHoursCommands _commands;

  ComplementaryHoursState get state => _state;
  ComplementaryHoursCommands get commands => _commands;

  ComplementaryHoursViewModel(IComplementaryHoursUseCaseFacade facade) {
    _state = ComplementaryHoursState();
    _commands = ComplementaryHoursCommands(
      state: _state,
      loadSummaryCommand: LoadComplementaryHoursSummaryCommand(facade),
    );
  }
}
