class EventPreview {
  final String id;
  final String title;
  final String category;
  final DateTime startsAt;
  final String location;
  final String description;
  final String imageUrl;

  const EventPreview({
    required this.id,
    required this.title,
    required this.category,
    required this.startsAt,
    required this.location,
    required this.description,
    required this.imageUrl,
  });
}
