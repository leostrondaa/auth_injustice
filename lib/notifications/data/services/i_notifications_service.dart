import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';

/// Fonte de dados das notificações.
///
/// A implementação atual é local; quando o backend estiver disponível, basta
/// registrar aqui uma implementação remota sem alterar a camada de apresentação.
abstract interface class INotificationsService {
  Future<NotificationsResult> getNotifications(String uid);

  Future<NotificationActionResult> markAsRead(
    String uid,
    String notificationId,
  );

  Future<NotificationActionResult> markAllAsRead(String uid);
}
