import 'package:autth_injustice_app/complementary_hours/presentation/commands/complementary_hours_commands.dart';

import 'complementary_hours_records_state_viewmodel.dart';

class ComplementaryHoursRecordsCommands {
  final ComplementaryHoursRecordsState state;
  final LoadComplementaryHoursRecordsCommand _loadRecordsCommand;
  final DeleteComplementaryHoursRecordCommand _deleteRecordCommand;

  ComplementaryHoursRecordsCommands({
    required this.state,
    required LoadComplementaryHoursRecordsCommand loadRecordsCommand,
    required DeleteComplementaryHoursRecordCommand deleteRecordCommand,
  })  : _loadRecordsCommand = loadRecordsCommand,
        _deleteRecordCommand = deleteRecordCommand;

  Future<void> loadRecords({bool forceRefresh = false}) async {
    if (state.loading.value || (!forceRefresh && state.loaded.value)) return;

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _loadRecordsCommand.executeWith(());
      result.fold(
        onSuccess: state.setRecords,
        onFailure: (failure) => state.showError(failure.msg),
      );
    } finally {
      state.setLoading(false);
    }
  }

  Future<bool> deleteRecord(String recordId) async {
    if (!state.startDeleting(recordId)) return false;

    state.clearError();
    var deleted = false;

    try {
      final result = await _deleteRecordCommand.executeWith(
        (recordId: recordId),
      );
      result.fold(
        onSuccess: (_) => deleted = true,
        onFailure: (failure) => state.showError(failure.msg),
      );
    } finally {
      state.finishDeleting(recordId);
    }

    return deleted;
  }

  void completeDismissal(String recordId) {
    state.removeRecord(recordId);
  }
}
