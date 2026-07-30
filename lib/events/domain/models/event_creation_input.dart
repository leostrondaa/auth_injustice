import 'event_category.dart';
import 'event_preview.dart';
import 'event_timing.dart';

class EventCreationInput {
  final String title;
  final EventCategory category;
  final DateTime startsAt;
  final EventEndMode endMode;
  final DateTime? endsAt;
  final String? locationLabel;
  final String description;
  final String? externalUrl;
  final int? complementaryMinutes;
  final String imageSource;
  final DateTime? publishAt;

  const EventCreationInput({
    required this.title,
    required this.category,
    required this.startsAt,
    required this.endMode,
    required this.description,
    required this.imageSource,
    this.externalUrl,
    this.endsAt,
    this.locationLabel,
    this.complementaryMinutes,
    this.publishAt,
  })  : assert(title != ''),
        assert(description != ''),
        assert(imageSource != ''),
        assert(
          endMode != EventEndMode.automatic || endsAt != null,
          'Automatic events require an end date.',
        ),
        assert(complementaryMinutes == null || complementaryMinutes > 0);

  EventPreview toPreview({
    required String id,
    String? remoteImageUrl,
  }) {
    return EventPreview(
      id: id,
      title: title,
      category: category,
      startsAt: startsAt,
      endMode: endMode,
      endsAt: endMode == EventEndMode.automatic ? endsAt : null,
      location: locationLabel ?? '',
      description: description,
      externalUrl: externalUrl,
      imageUrl: remoteImageUrl ?? imageSource,
      publishAt: publishAt,
    );
  }
}
