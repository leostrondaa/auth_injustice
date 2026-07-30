import 'package:autth_injustice_app/events/presentation/commands/events_commands.dart';

import 'event_management_state_viewmodel.dart';

class EventManagementCommands {
  final EventManagementState state;
  final LoadManagementEventsCatalogCommand _loadEventsCatalogCommand;
  final DeleteEventCommand _deleteEventCommand;
  final CancelEventCommand _cancelEventCommand;
  final EndEventCommand _endEventCommand;

  EventManagementCommands({
    required this.state,
    required LoadManagementEventsCatalogCommand loadEventsCatalogCommand,
    required DeleteEventCommand deleteEventCommand,
    required CancelEventCommand cancelEventCommand,
    required EndEventCommand endEventCommand,
  })  : _loadEventsCatalogCommand = loadEventsCatalogCommand,
        _deleteEventCommand = deleteEventCommand,
        _cancelEventCommand = cancelEventCommand,
        _endEventCommand = endEventCommand;

  Future<void> loadEvents({bool forceRefresh = false}) async {
    if (state.loading.value || (!forceRefresh && state.hasLoaded)) return;

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _loadEventsCatalogCommand.executeWith(());
      result.fold(
        onSuccess: state.setCatalog,
        onFailure: (failure) => state.showError(failure.msg),
      );
    } finally {
      state.setLoading(false);
    }
  }

  Future<bool> deleteEvent(String eventId) async {
    if (state.deletingEventId.value != null ||
        state.endingEventId.value != null) {
      return false;
    }

    state.setDeletingEvent(eventId);
    try {
      final result = await _deleteEventCommand.executeWith(
        (eventId: eventId),
      );

      final deleted = result.fold(
        onSuccess: (value) => value,
        onFailure: (_) => false,
      );
      if (!deleted) return false;

      await Future<void>.delayed(const Duration(milliseconds: 210));
      state.removeEvent(eventId);
      return true;
    } finally {
      state.setDeletingEvent(null);
    }
  }

  Future<bool> endEvent(String eventId) async {
    if (state.endingEventId.value != null ||
        state.deletingEventId.value != null) {
      return false;
    }

    state.setEndingEvent(eventId);
    try {
      final result = await _endEventCommand.executeWith(
        (eventId: eventId),
      );

      final ended = result.fold(
        onSuccess: (value) => value,
        onFailure: (_) => false,
      );
      if (!ended) return false;

      await Future<void>.delayed(const Duration(milliseconds: 210));
      state.removeEvent(eventId);
      return true;
    } finally {
      state.setEndingEvent(null);
    }
  }

  Future<bool> cancelEvent({
    required String eventId,
    required String reason,
  }) async {
    if (state.deletingEventId.value != null ||
        state.endingEventId.value != null) {
      return false;
    }

    state.setDeletingEvent(eventId);
    try {
      final result = await _cancelEventCommand.executeWith(
        (
          eventId: eventId,
          reason: reason,
        ),
      );

      final cancelled = result.fold(
        onSuccess: (value) => value,
        onFailure: (_) => false,
      );
      if (!cancelled) return false;

      await Future<void>.delayed(const Duration(milliseconds: 210));
      state.removeEvent(eventId);
      return true;
    } finally {
      state.setDeletingEvent(null);
    }
  }
}
