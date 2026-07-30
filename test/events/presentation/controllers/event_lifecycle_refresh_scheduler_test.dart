import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:autth_injustice_app/events/presentation/controllers/event_lifecycle_refresh_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/test_event_categories.dart';

void main() {
  test('schedules the closest publication, start, or end transition', () {
    final now = DateTime(2026, 7, 30, 10);
    final event = EventPreview(
      id: 'event',
      title: 'Event',
      category: TestEventCategories.other,
      startsAt: now.add(const Duration(hours: 3)),
      endsAt: now.add(const Duration(hours: 5)),
      publishAt: now.add(const Duration(hours: 1)),
      endMode: EventEndMode.automatic,
      location: '',
      description: 'Test event',
      imageUrl: '',
    );

    expect(
      EventLifecycleRefreshScheduler.nextTransition(
        events: [event],
        now: now,
      ),
      event.publishAt,
    );
  });
}
