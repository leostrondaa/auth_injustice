import 'package:autth_injustice_app/events/presentation/commands/events_commands.dart';

import 'event_editor_state_viewmodel.dart';

class EventEditorCommands {
  final EventEditorState state;
  final LoadEventDetailsCommand _loadEventDetailsCommand;
  final CreateEventCommand _createEventCommand;
  final UpdateEventCommand _updateEventCommand;

  EventEditorCommands({
    required this.state,
    required LoadEventDetailsCommand loadEventDetailsCommand,
    required CreateEventCommand createEventCommand,
    required UpdateEventCommand updateEventCommand,
  })  : _loadEventDetailsCommand = loadEventDetailsCommand,
        _createEventCommand = createEventCommand,
        _updateEventCommand = updateEventCommand;

  Future<bool> loadEventForEditing(String eventId) async {
    if (state.loading.value) return false;

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _loadEventDetailsCommand.executeWith(
        (eventId: eventId),
      );

      return result.fold(
        onSuccess: (details) {
          state.initializeForEdit(
            eventId: eventId,
            details: details,
          );
          return true;
        },
        onFailure: (failure) {
          state.showError(failure.msg);
          return false;
        },
      );
    } finally {
      state.setLoading(false);
    }
  }

  Future<bool> createEvent() async {
    if (state.loading.value) return false;

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _createEventCommand.executeWith(
        (draft: state.draft.value),
      );

      return result.fold(
        onSuccess: (event) {
          state.setSavedEvent(event);
          return true;
        },
        onFailure: (failure) {
          state.showError(failure.msg);
          return false;
        },
      );
    } finally {
      state.setLoading(false);
    }
  }

  Future<bool> updateEvent() async {
    if (state.loading.value) return false;

    final eventId = state.editingEventId.value;
    if (eventId == null) return false;

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _updateEventCommand.executeWith(
        (
          eventId: eventId,
          draft: state.draft.value,
        ),
      );

      return result.fold(
        onSuccess: (event) {
          state.setSavedEvent(event);
          return true;
        },
        onFailure: (failure) {
          state.showError(failure.msg);
          return false;
        },
      );
    } finally {
      state.setLoading(false);
    }
  }
}
