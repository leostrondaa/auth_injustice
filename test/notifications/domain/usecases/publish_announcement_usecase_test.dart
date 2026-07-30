import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/notifications/data/repositories/i_notifications_repository.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_draft.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_input.dart';
import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';
import 'package:autth_injustice_app/notifications/domain/usecases/notifications_usecases_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PublishAnnouncementUseCase', () {
    test('does not publish an invalid draft', () async {
      final repository = _NotificationsRepositorySpy();
      final useCase = _useCaseFor(
        AccountRole.administrator,
        repository,
      );

      final result = await useCase(
        (draft: const NotificationAnnouncementDraft()),
      );

      expect(repository.publishCalls, 0);
      expect(
        result.failureValueOrNull?.msg,
        'notificationEditorInvalidTitle',
      );
    });

    test('normalizes and publishes a valid announcement', () async {
      final repository = _NotificationsRepositorySpy();
      final useCase = _useCaseFor(
        AccountRole.administrator,
        repository,
      );

      await useCase(
        (
          draft: const NotificationAnnouncementDraft(
            title: '  Biblioteca fechada  ',
            message: '  A biblioteca ficará fechada durante a manhã.  ',
            externalUrl: ' ifpr.edu.br/avisos ',
          ),
        ),
      );

      expect(repository.publishCalls, 1);
      expect(repository.received?.title, 'Biblioteca fechada');
      expect(
        repository.received?.message,
        'A biblioteca ficará fechada durante a manhã.',
      );
      expect(repository.received?.externalUrl, 'https://ifpr.edu.br/avisos');
    });

    test('does not allow an event manager to publish announcements', () async {
      final repository = _NotificationsRepositorySpy();
      final useCase = _useCaseFor(
        AccountRole.eventManager,
        repository,
      );

      final result = await useCase(
        (
          draft: const NotificationAnnouncementDraft(
            title: 'Aviso importante',
            message: 'Esta é uma descrição válida para o aviso.',
          ),
        ),
      );

      expect(repository.publishCalls, 0);
      expect(
        result.failureValueOrNull?.msg,
        'notificationManagementUnauthorized',
      );
    });
  });
}

PublishAnnouncementUseCase _useCaseFor(
  AccountRole role,
  INotificationsRepository repository,
) {
  return PublishAnnouncementUseCase(
    notificationsRepository: repository,
    authorizationService: AuthorizationService(
      currentAccountProvider: _RoleAccountProvider(role),
    ),
  );
}

class _RoleAccountProvider implements ICurrentAccountProvider {
  final AccountRole role;

  _RoleAccountProvider(this.role);

  @override
  Account get currentAccount => Account(
        uid: 'test-user',
        email: 'test@ifpr.edu.br',
        displayName: 'Test User',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
        role: role,
      );

  @override
  String get currentUid => currentAccount.uid;
}

class _NotificationsRepositorySpy implements INotificationsRepository {
  int publishCalls = 0;
  NotificationAnnouncementInput? received;

  @override
  Future<NotificationPublishResult> publishAnnouncement(
    NotificationAnnouncementInput input,
  ) {
    publishCalls++;
    received = input;
    return Future.value(Error(RemoteFailure('testRemoteFailure')));
  }

  @override
  Future<NotificationsResult> getNotifications() => throw UnimplementedError();

  @override
  Future<NotificationActionResult> markAllAsRead() =>
      throw UnimplementedError();

  @override
  Future<NotificationActionResult> markAsRead(String notificationId) =>
      throw UnimplementedError();
}
