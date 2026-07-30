import 'package:autth_injustice_app/institution/domain/institution_package.dart';
import 'package:autth_injustice_app/institution/domain/institution_package_validator.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';

abstract final class InstitutionPackageRegistry {
  static const configuredPackageId = String.fromEnvironment(
    'INSTITUTION_PACKAGE',
    defaultValue: 'ifpr-pgua',
  );

  static InstitutionPackage resolve({
    String packageId = configuredPackageId,
  }) {
    final package = switch (packageId) {
      'ifpr-pgua' || 'ifpr_pgua' || 'ifpr' => const IfprPguaPackage(),
      _ => throw StateError(
          'Unknown institution package "$packageId". '
          'Add it to InstitutionPackageRegistry before building the app.',
        ),
    };

    InstitutionPackageValidator.ensureValid(package);
    return package;
  }
}
