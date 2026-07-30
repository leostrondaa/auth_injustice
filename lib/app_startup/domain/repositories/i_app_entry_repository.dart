abstract interface class IAppEntryRepository {
  Future<bool> hasCompletedInitialPage();

  Future<void> markInitialPageCompleted();

  Future<void> resetInitialPage();
}
