import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/command.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/notifications/domain/facades/i_notifications_use_case_facade.dart';
import 'package:autth_injustice_app/notifications/domain/models/app_notification.dart';
import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';

final class LoadNotificationsCommand extends ParameterizedCommand<
    List<AppNotification>, Failure, NotificationsNoParams> {
  final INotificationsUseCaseFacade _notificationsFacade;

  LoadNotificationsCommand(this._notificationsFacade);

  @override
  Future<NotificationsResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('notificationsLoadErrorMessage')),
      );
    }

    return _notificationsFacade.getNotifications(parameter!);
  }
}

final class MarkNotificationAsReadCommand
    extends ParameterizedCommand<void, Failure, NotificationIdParams> {
  final INotificationsUseCaseFacade _notificationsFacade;

  MarkNotificationAsReadCommand(this._notificationsFacade);

  @override
  Future<NotificationActionResult> execute() {
    if (parameter == null || parameter!.notificationId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('notificationsLoadErrorMessage')),
      );
    }

    return _notificationsFacade.markAsRead(parameter!);
  }
}

final class MarkAllNotificationsAsReadCommand
    extends ParameterizedCommand<void, Failure, NotificationsNoParams> {
  final INotificationsUseCaseFacade _notificationsFacade;

  MarkAllNotificationsAsReadCommand(this._notificationsFacade);

  @override
  Future<NotificationActionResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('notificationsLoadErrorMessage')),
      );
    }

    return _notificationsFacade.markAllAsRead(parameter!);
  }
}

final class PublishAnnouncementCommand extends ParameterizedCommand<
    AppNotification, Failure, PublishAnnouncementParams> {
  final INotificationsUseCaseFacade _notificationsFacade;

  PublishAnnouncementCommand(this._notificationsFacade);

  @override
  Future<NotificationPublishResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('notificationEditorRequiredFields')),
      );
    }

    return _notificationsFacade.publishAnnouncement(parameter!);
  }
}
