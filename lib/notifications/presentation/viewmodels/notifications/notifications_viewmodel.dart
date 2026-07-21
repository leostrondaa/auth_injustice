import 'package:autth_injustice_app/notifications/domain/facades/i_notifications_use_case_facade.dart';
import 'package:autth_injustice_app/notifications/presentation/commands/notifications_commands.dart';

import 'notifications_commands_viewmodel.dart';
import 'notifications_state_viewmodel.dart';

class NotificationsViewModel {
  late final NotificationsState _state;
  late final NotificationsCommands _commands;

  NotificationsState get state => _state;
  NotificationsCommands get commands => _commands;

  NotificationsViewModel(INotificationsUseCaseFacade facade) {
    _state = NotificationsState();
    _commands = NotificationsCommands(
      state: _state,
      loadNotificationsCommand: LoadNotificationsCommand(facade),
      markNotificationAsReadCommand: MarkNotificationAsReadCommand(facade),
      markAllNotificationsAsReadCommand:
          MarkAllNotificationsAsReadCommand(facade),
    );
  }
}
