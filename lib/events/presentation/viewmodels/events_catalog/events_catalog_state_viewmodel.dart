import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:autth_injustice_app/events/domain/models/events_catalog.dart';
import 'package:autth_injustice_app/core/patterns/async_load_state.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EventsCatalogState with AsyncLoadState {
  final featuredEvents = signal<List<EventPreview>>(const []);
  final futureEvents = signal<List<EventPreview>>(const []);

  bool get hasEvents =>
      featuredEvents.value.isNotEmpty || futureEvents.value.isNotEmpty;

  void setCatalog(EventsCatalog catalog) {
    final activeCatalog = catalog.activeAt(DateTime.now());
    featuredEvents.value = activeCatalog.featuredEvents;
    futureEvents.value = activeCatalog.futureEvents;
    markLoaded();
  }
}
