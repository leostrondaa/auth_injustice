import 'package:autth_injustice_app/institution/domain/models/institution_resource.dart';

abstract final class IfprPguaEventImages {
  static const artsAndCulture = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/event_banners/arts_culture.png',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/png',
  );

  static const sustainability = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/event_banners/sustainability.png',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/png',
  );

  static const sports = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/event_banners/sports.jpg',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/jpeg',
  );

  static const community = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/event_banners/community.jpg',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/jpeg',
  );

  static const healthAndWellness = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/event_banners/health_wellness.jpg',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/jpeg',
  );

  static const institutional = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/event_banners/ifpr_institutional.jpg',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/jpeg',
  );

  static const technology = InstitutionResource.asset(
    path: 'assets/institutions/ifpr-pgua/event_banners/technology.jpg',
    kind: InstitutionResourceKind.rasterImage,
    contentType: 'image/jpeg',
  );

  static const values = [
    artsAndCulture,
    sustainability,
    sports,
    community,
    healthAndWellness,
    institutional,
    technology,
  ];
}
