import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_input.dart';

/// Fonte de dados das notificações.
///
/// O adaptador ativo e escolhido em `backend_dependency_bindings.dart`.
/// Trocar a fonte de dados nao exige alteracoes na apresentacao.
abstract interface class INotificationsService {
  Future<NotificationsResult> getNotifications(String uid);

  Future<NotificationActionResult> markAsRead(
    String uid,
    String notificationId,
  );

  Future<NotificationActionResult> markAllAsRead(String uid);

  /// Publishes a campus-wide manual update.
  ///
  /// A production adapter must authorize [actorUid] on the server and create
  /// the notification with a server timestamp.
  Future<NotificationPublishResult> publishAnnouncement({
    required String actorUid,
    required NotificationAnnouncementInput input,
  });
}
