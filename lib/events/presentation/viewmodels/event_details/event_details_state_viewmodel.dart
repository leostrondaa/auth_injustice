import 'package:autth_injustice_app/events/domain/models/event_details.dart';
import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EventDetailsState {
  final loading = signal(false);
  final updatingPersonalRecord = signal(false);
  final event = signal<EventPreview?>(null);
  final addedToPersonalHistory = signal(false);
  final complementaryHours = signal<double?>(null);
  final errorMessage = signal<String?>(null);

  void setLoading(bool value) {
    loading.value = value;
  }

  void setAddedToPersonalHistory(bool value) {
    addedToPersonalHistory.value = value;
  }

  void setUpdatingPersonalRecord(bool value) {
    updatingPersonalRecord.value = value;
  }

  void setDetails(EventDetails details) {
    event.value = details.event;
    addedToPersonalHistory.value = details.addedToPersonalHistory;
    complementaryHours.value = details.complementaryHours;
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }

  void reset() {
    setLoading(false);
    setUpdatingPersonalRecord(false);
    event.value = null;
    setAddedToPersonalHistory(false);
    complementaryHours.value = null;
    clearError();
  }
}
