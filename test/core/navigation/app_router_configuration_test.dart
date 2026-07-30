import 'package:autth_injustice_app/core/navigation/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds the complete route tree without assertions', () {
    expect(AppRouter.router.routeInformationProvider, isNotNull);
  });
}
