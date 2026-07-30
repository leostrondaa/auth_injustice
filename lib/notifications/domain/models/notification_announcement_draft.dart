import 'package:autth_injustice_app/core/validation/external_url.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_input.dart';

const _unsetAnnouncementDraftValue = Object();

class NotificationAnnouncementDraft {
  final String title;
  final String message;
  final String? externalUrl;

  const NotificationAnnouncementDraft({
    this.title = '',
    this.message = '',
    this.externalUrl,
  });

  NotificationAnnouncementInput toInput() {
    return NotificationAnnouncementInput(
      title: title.trim(),
      message: message.trim(),
      externalUrl: ExternalUrl.normalize(externalUrl),
    );
  }

  NotificationAnnouncementDraft copyWith({
    String? title,
    String? message,
    Object? externalUrl = _unsetAnnouncementDraftValue,
  }) {
    return NotificationAnnouncementDraft(
      title: title ?? this.title,
      message: message ?? this.message,
      externalUrl: identical(externalUrl, _unsetAnnouncementDraftValue)
          ? this.externalUrl
          : externalUrl as String?,
    );
  }
}
