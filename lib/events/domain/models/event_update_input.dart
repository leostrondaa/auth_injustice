import 'event_category.dart';
import 'event_preview.dart';
import 'event_timing.dart';

class EventUpdateInput {
  final String title;
  final EventCategory category;
  final DateTime startsAt;
  final EventEndMode endMode;
  final DateTime? endsAt;
  final String? locationLabel;
  final String description;
  final String? externalUrl;
  final int? complementaryMinutes;
  final String? replacementImageSource;
  final DateTime? publishAt;

  const EventUpdateInput({
    required this.title,
    required this.category,
    required this.startsAt,
    required this.endMode,
    required this.description,
    this.externalUrl,
    this.endsAt,
    this.locationLabel,
    this.complementaryMinutes,
    this.replacementImageSource,
    this.publishAt,
  })  : assert(title != ''),
        assert(description != ''),
        assert(
          endMode != EventEndMode.automatic || endsAt != null,
          'Automatic events require an end date.',
        ),
        assert(complementaryMinutes == null || complementaryMinutes > 0);

  EventPreview applyTo(
    EventPreview current, {
    String? replacementRemoteImageUrl,
  }) {
    return current.copyWith(
      title: title,
      category: category,
      startsAt: startsAt,
      endMode: endMode,
      endsAt: endMode == EventEndMode.automatic ? endsAt : null,
      location: locationLabel ?? '',
      description: description,
      externalUrl: externalUrl,
      imageUrl: replacementRemoteImageUrl ??
          replacementImageSource ??
          current.imageUrl,
      publishAt: publishAt,
    );
  }
}
