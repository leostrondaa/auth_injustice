enum AppNotificationType {
  event,
  reminder,
  update,
}

class AppNotification {
  final String id;
  final AppNotificationType type;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;
  final String? eventId;
  final String? authorUid;
  final String? externalUrl;

  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
    this.eventId,
    this.authorUid,
    this.externalUrl,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      type: type,
      title: title,
      message: message,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      eventId: eventId,
      authorUid: authorUid,
      externalUrl: externalUrl,
    );
  }
}
