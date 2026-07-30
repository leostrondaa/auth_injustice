import 'account_role.dart';

enum AppPermission {
  createEvent,
  editEvent,
  endEvent,
  publishEvent,
  archiveEvent,
  publishAnnouncement,
  manageAccounts,
  assignRoles,
}

extension AccountRolePermissions on AccountRole {
  Set<AppPermission> get permissions => switch (this) {
        AccountRole.student => const {},
        AccountRole.eventManager => const {
            AppPermission.createEvent,
            AppPermission.editEvent,
            AppPermission.endEvent,
            AppPermission.publishEvent,
            AppPermission.archiveEvent,
          },
        AccountRole.administrator => AppPermission.values.toSet(),
      };

  bool can(AppPermission permission) => permissions.contains(permission);
}
