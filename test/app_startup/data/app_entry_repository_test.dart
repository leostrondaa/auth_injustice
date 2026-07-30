import 'package:autth_injustice_app/app_startup/data/repositories/app_entry_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('persists and resets completion of the initial page', () async {
    SharedPreferences.setMockInitialValues({});
    final repository = AppEntryRepositoryImpl();

    expect(await repository.hasCompletedInitialPage(), isFalse);

    await repository.markInitialPageCompleted();
    expect(await repository.hasCompletedInitialPage(), isTrue);

    await repository.resetInitialPage();
    expect(await repository.hasCompletedInitialPage(), isFalse);
  });
}
