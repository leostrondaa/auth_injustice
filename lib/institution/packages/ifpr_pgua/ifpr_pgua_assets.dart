import 'package:autth_injustice_app/institution/domain/models/institution_resource.dart';

abstract final class IfprPguaAssets {
  static const logoBlack = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/branding/logo_black.png',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/png',
  );

  static const logoWhite = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/branding/logo_white.png',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/png',
  );
}
