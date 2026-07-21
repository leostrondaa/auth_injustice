import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:autth_injustice_app/events/domain/models/events_catalog.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EventsCatalogState {
  final loading = signal(false);
  final featuredEvents = signal<List<EventPreview>>(const []);
  final futureEvents = signal<List<EventPreview>>(const []);
  final errorMessage = signal<String?>(null);

  bool get hasEvents =>
      featuredEvents.value.isNotEmpty || futureEvents.value.isNotEmpty;

  void setLoading(bool value) {
    loading.value = value;
  }

  void setCatalog(EventsCatalog catalog) {
    featuredEvents.value = List.unmodifiable(catalog.featuredEvents);
    futureEvents.value = List.unmodifiable(catalog.futureEvents);
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }
}
