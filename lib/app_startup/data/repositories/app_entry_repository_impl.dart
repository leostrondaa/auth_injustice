import 'package:autth_injustice_app/app_startup/domain/repositories/i_app_entry_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppEntryRepositoryImpl implements IAppEntryRepository {
  static const _initialPageCompletedKey = 'app_startup.initial_page_completed';

  const AppEntryRepositoryImpl();

  @override
  Future<bool> hasCompletedInitialPage() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_initialPageCompletedKey) ?? false;
  }

  @override
  Future<void> markInitialPageCompleted() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_initialPageCompletedKey, true);
  }

  @override
  Future<void> resetInitialPage() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_initialPageCompletedKey);
  }
}
