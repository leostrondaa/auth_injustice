import 'event_preview.dart';

class EventsCatalog {
  final List<EventPreview> featuredEvents;
  final List<EventPreview> futureEvents;

  const EventsCatalog({
    required this.featuredEvents,
    required this.futureEvents,
  });

  EventsCatalog activeAt(DateTime dateTime) {
    final uniqueEvents = <String, EventPreview>{
      for (final event in [...featuredEvents, ...futureEvents]) event.id: event,
    };
    final ongoing = uniqueEvents.values
        .where((event) => event.isOngoingAt(dateTime))
        .toList()
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    final upcoming = uniqueEvents.values
        .where((event) => event.isUpcomingAt(dateTime))
        .toList()
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));

    return EventsCatalog(
      featuredEvents: List.unmodifiable(ongoing),
      futureEvents: List.unmodifiable(upcoming),
    );
  }
}
