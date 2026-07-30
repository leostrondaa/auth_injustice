enum EventEndMode {
  automatic,
  manual,
}

enum EventLifecycleStatus {
  upcoming,
  ongoing,
  ended,
}

abstract final class EventTiming {
  static EventLifecycleStatus statusAt({
    required DateTime now,
    required DateTime startsAt,
    required EventEndMode endMode,
    DateTime? endsAt,
    DateTime? endedAt,
  }) {
    if (endedAt != null) return EventLifecycleStatus.ended;
    if (now.isBefore(startsAt)) return EventLifecycleStatus.upcoming;

    if (endMode == EventEndMode.automatic &&
        (endsAt == null || !now.isBefore(endsAt))) {
      return EventLifecycleStatus.ended;
    }

    return EventLifecycleStatus.ongoing;
  }

  static bool isValidAutomaticEnd({
    required DateTime startsAt,
    required DateTime? endsAt,
  }) {
    return endsAt != null && endsAt.isAfter(startsAt);
  }
}
