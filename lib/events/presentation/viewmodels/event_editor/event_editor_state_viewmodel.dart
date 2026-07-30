import 'package:autth_injustice_app/events/domain/models/event_details.dart';
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EventEditorState {
  final draft = signal(const EventEditorDraft());
  final currentStep = signal(0);
  final loading = signal(false);
  final errorMessage = signal<String?>(null);
  final savedEvent = signal<EventDetails?>(null);
  final editingEventId = signal<String?>(null);

  EventPublicationMode get publicationMode => draft.value.publicationMode;

  bool get hasComplementaryHours => draft.value.complementaryMinutes != null;

  int get complementaryHours =>
      (draft.value.complementaryMinutes ?? 0) ~/ Duration.minutesPerHour;

  int get complementaryMinutes =>
      (draft.value.complementaryMinutes ?? 0) % Duration.minutesPerHour;

  void reset() {
    draft.value = const EventEditorDraft();
    currentStep.value = 0;
    loading.value = false;
    errorMessage.value = null;
    savedEvent.value = null;
    editingEventId.value = null;
  }

  void initializeForEdit({
    required String eventId,
    required EventDetails details,
  }) {
    draft.value = EventEditorDraft.fromDetails(details);
    currentStep.value = 7;
    loading.value = false;
    errorMessage.value = null;
    savedEvent.value = null;
    editingEventId.value = eventId;
  }

  void updateDraft(EventEditorDraft value) {
    draft.value = value;
    clearError();
  }

  void updateEventStart(DateTime startsAt) {
    final current = draft.value;
    var endsAt = current.endsAt;
    if (current.endMode == EventEndMode.automatic &&
        (endsAt == null || !endsAt.isAfter(startsAt))) {
      endsAt = startsAt.add(const Duration(hours: 2));
    }

    updateDraft(
      current.copyWith(
        startsAt: startsAt,
        endsAt: endsAt,
      ),
    );
  }

  void setEndMode(EventEndMode mode) {
    final current = draft.value;
    if (current.endMode == mode) return;

    updateDraft(
      current.copyWith(
        endMode: mode,
        endsAt: mode == EventEndMode.automatic
            ? (current.endsAt ??
                current.startsAt?.add(const Duration(hours: 2)))
            : null,
      ),
    );
  }

  void setPublicationMode(
    EventPublicationMode mode, {
    required DateTime now,
  }) {
    final current = draft.value;
    if (current.publicationMode == mode) return;

    if (mode == EventPublicationMode.now) {
      updateDraft(current.copyWith(publishAt: null));
      return;
    }

    final eventAt = current.startsAt;
    if (eventAt == null) return;

    var suggestion = now.add(const Duration(minutes: 30));
    if (!suggestion.isBefore(eventAt)) {
      suggestion = eventAt.subtract(const Duration(minutes: 1));
    }
    updateDraft(current.copyWith(publishAt: suggestion));
  }

  void setComplementaryHoursEnabled(bool enabled) {
    updateDraft(
      draft.value.copyWith(
        complementaryMinutes: enabled ? 0 : null,
      ),
    );
  }

  void setComplementaryHours(int hours) {
    _setComplementaryParts(
      hours: hours,
      minutes: complementaryMinutes,
    );
  }

  void setComplementaryMinutes(int minutes) {
    _setComplementaryParts(
      hours: complementaryHours,
      minutes: minutes,
    );
  }

  void _setComplementaryParts({
    required int hours,
    required int minutes,
  }) {
    updateDraft(
      draft.value.copyWith(
        complementaryMinutes: (hours * Duration.minutesPerHour) + minutes,
      ),
    );
  }

  void setCurrentStep(int value) {
    currentStep.value = value;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }

  void setSavedEvent(EventDetails value) {
    savedEvent.value = value;
  }
}
