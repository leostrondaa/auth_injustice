import 'event_preview.dart';

class EventDetails {
  final EventPreview event;
  final bool addedToPersonalHistory;
  final int? complementaryMinutes;

  const EventDetails({
    required this.event,
    required this.addedToPersonalHistory,
    this.complementaryMinutes,
  }) : assert(complementaryMinutes == null || complementaryMinutes >= 0);

  double? get complementaryHours => switch (complementaryMinutes) {
        final minutes? => minutes / Duration.minutesPerHour,
        null => null,
      };
}
