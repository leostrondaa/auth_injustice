import 'package:autth_injustice_app/complementary_hours/presentation/commands/complementary_hours_commands.dart';

import 'complementary_hours_state_viewmodel.dart';

class ComplementaryHoursCommands {
  final ComplementaryHoursState state;
  final LoadComplementaryHoursSummaryCommand _loadSummaryCommand;

  ComplementaryHoursCommands({
    required this.state,
    required LoadComplementaryHoursSummaryCommand loadSummaryCommand,
  }) : _loadSummaryCommand = loadSummaryCommand;

  Future<void> loadSummary({bool forceRefresh = false}) async {
    if (state.loading.value || (!forceRefresh && state.hasLoaded)) return;

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _loadSummaryCommand.executeWith(());
      result.fold(
        onSuccess: state.setSummary,
        onFailure: (failure) => state.showError(failure.msg),
      );
    } finally {
      state.setLoading(false);
    }
  }
}
