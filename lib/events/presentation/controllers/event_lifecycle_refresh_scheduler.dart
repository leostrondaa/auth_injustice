import 'dart:async';

import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:flutter/foundation.dart';

class EventLifecycleRefreshScheduler {
  Timer? _timer;
  DateTime? _scheduledFor;

  void schedule({
    required Iterable<EventPreview> events,
    required VoidCallback onRefresh,
  }) {
    final now = DateTime.now();
    final next = nextTransition(events: events, now: now);

    if (next == _scheduledFor && _timer?.isActive == true) return;

    _timer?.cancel();
    _scheduledFor = next;
    if (next == null) return;

    final delay = next.difference(now) + const Duration(milliseconds: 80);
    _timer = Timer(delay, () {
      _scheduledFor = null;
      onRefresh();
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _scheduledFor = null;
  }

  @visibleForTesting
  static DateTime? nextTransition({
    required Iterable<EventPreview> events,
    required DateTime now,
  }) {
    DateTime? next;

    void consider(DateTime? candidate) {
      if (candidate == null || !candidate.isAfter(now)) return;
      if (next == null || candidate.isBefore(next!)) next = candidate;
    }

    for (final event in events) {
      consider(event.publishAt);
      consider(event.startsAt);
      consider(event.endsAt);
    }

    return next;
  }
}
