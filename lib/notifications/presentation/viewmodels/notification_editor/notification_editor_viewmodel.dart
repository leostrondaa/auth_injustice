import 'package:autth_injustice_app/notifications/domain/facades/i_notifications_use_case_facade.dart';
import 'package:autth_injustice_app/notifications/presentation/commands/notifications_commands.dart';

import 'notification_editor_commands_viewmodel.dart';
import 'notification_editor_state_viewmodel.dart';

class NotificationEditorViewModel {
  late final NotificationEditorState _state;
  late final NotificationEditorCommands _commands;

  NotificationEditorState get state => _state;
  NotificationEditorCommands get commands => _commands;

  NotificationEditorViewModel(INotificationsUseCaseFacade facade) {
    _state = NotificationEditorState();
    _commands = NotificationEditorCommands(
      state: _state,
      publishAnnouncementCommand: PublishAnnouncementCommand(facade),
    );
  }
}
