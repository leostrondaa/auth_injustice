enum AccountRole {
  student,
  eventManager,
  administrator;

  static AccountRole fromStorage(String? value) {
    return AccountRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => AccountRole.student,
    );
  }
}
