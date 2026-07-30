class NotificationAnnouncementInput {
  final String title;
  final String message;
  final String? externalUrl;

  const NotificationAnnouncementInput({
    required this.title,
    required this.message,
    this.externalUrl,
  })  : assert(title != ''),
        assert(message != '');
}
