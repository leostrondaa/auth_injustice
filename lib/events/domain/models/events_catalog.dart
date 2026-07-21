import 'event_preview.dart';

class EventsCatalog {
  final List<EventPreview> featuredEvents;
  final List<EventPreview> futureEvents;

  const EventsCatalog({
    required this.featuredEvents,
    required this.futureEvents,
  });
}
