import 'package:autth_injustice_app/core/validation/external_url.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_draft.dart';

enum NotificationAnnouncementValidationIssue {
  invalidTitle('notificationEditorInvalidTitle'),
  invalidMessage('notificationEditorInvalidDescription'),
  invalidExternalLink('notificationEditorInvalidExternalLink');

  final String messageKey;

  const NotificationAnnouncementValidationIssue(this.messageKey);
}

abstract final class NotificationAnnouncementRules {
  static const titleMinLength = 3;
  static const titleMaxLength = 80;
  static const messageMinLength = 10;
  static const messageMaxLength = 1000;
}

abstract final class NotificationAnnouncementValidator {
  static NotificationAnnouncementValidationIssue? validateTitle(
    NotificationAnnouncementDraft draft,
  ) {
    final length = draft.title.trim().length;
    if (length < NotificationAnnouncementRules.titleMinLength ||
        length > NotificationAnnouncementRules.titleMaxLength) {
      return NotificationAnnouncementValidationIssue.invalidTitle;
    }
    return null;
  }

  static NotificationAnnouncementValidationIssue? validateMessage(
    NotificationAnnouncementDraft draft,
  ) {
    final length = draft.message.trim().length;
    if (length < NotificationAnnouncementRules.messageMinLength ||
        length > NotificationAnnouncementRules.messageMaxLength) {
      return NotificationAnnouncementValidationIssue.invalidMessage;
    }
    return null;
  }

  static NotificationAnnouncementValidationIssue? validateExternalLink(
    NotificationAnnouncementDraft draft,
  ) {
    if (!ExternalUrl.isValidOptional(draft.externalUrl)) {
      return NotificationAnnouncementValidationIssue.invalidExternalLink;
    }
    return null;
  }

  static NotificationAnnouncementValidationIssue? validateForPublishing(
    NotificationAnnouncementDraft draft,
  ) {
    return validateTitle(draft) ??
        validateMessage(draft) ??
        validateExternalLink(draft);
  }
}
