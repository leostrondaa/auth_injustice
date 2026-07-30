import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:autth_injustice_app/events/domain/models/events_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/test_event_categories.dart';

void main() {
  final now = DateTime(2026, 7, 30, 14);

  group('EventTiming', () {
    test('automatic event moves from upcoming to ongoing and ended', () {
      final startsAt = now.add(const Duration(hours: 1));
      final endsAt = startsAt.add(const Duration(hours: 2));

      expect(
        EventTiming.statusAt(
          now: now,
          startsAt: startsAt,
          endMode: EventEndMode.automatic,
          endsAt: endsAt,
        ),
        EventLifecycleStatus.upcoming,
      );
      expect(
        EventTiming.statusAt(
          now: startsAt,
          startsAt: startsAt,
          endMode: EventEndMode.automatic,
          endsAt: endsAt,
        ),
        EventLifecycleStatus.ongoing,
      );
      expect(
        EventTiming.statusAt(
          now: endsAt,
          startsAt: startsAt,
          endMode: EventEndMode.automatic,
          endsAt: endsAt,
        ),
        EventLifecycleStatus.ended,
      );
    });

    test('manual event stays ongoing until endedAt is recorded', () {
      final startsAt = now.subtract(const Duration(hours: 1));

      expect(
        EventTiming.statusAt(
          now: now,
          startsAt: startsAt,
          endMode: EventEndMode.manual,
        ),
        EventLifecycleStatus.ongoing,
      );
      expect(
        EventTiming.statusAt(
          now: now,
          startsAt: startsAt,
          endMode: EventEndMode.manual,
          endedAt: now.subtract(const Duration(minutes: 1)),
        ),
        EventLifecycleStatus.ended,
      );
    });
  });

  test('catalog places only ongoing events in featured', () {
    final ongoing = _event(
      id: 'ongoing',
      startsAt: now.subtract(const Duration(hours: 1)),
      endsAt: now.add(const Duration(hours: 1)),
    );
    final upcoming = _event(
      id: 'upcoming',
      startsAt: now.add(const Duration(days: 1)),
      endsAt: now.add(const Duration(days: 1, hours: 2)),
    );
    final ended = _event(
      id: 'ended',
      startsAt: now.subtract(const Duration(hours: 3)),
      endsAt: now.subtract(const Duration(hours: 1)),
    );

    final active = EventsCatalog(
      featuredEvents: [upcoming, ended],
      futureEvents: [ongoing],
    ).activeAt(now);

    expect(active.featuredEvents.map((event) => event.id), ['ongoing']);
    expect(active.futureEvents.map((event) => event.id), ['upcoming']);
  });
}

EventPreview _event({
  required String id,
  required DateTime startsAt,
  required DateTime endsAt,
}) {
  return EventPreview(
    id: id,
    title: id,
    category: TestEventCategories.other,
    startsAt: startsAt,
    endsAt: endsAt,
    endMode: EventEndMode.automatic,
    location: '',
    description: 'Test event',
    imageUrl: '',
  );
}
