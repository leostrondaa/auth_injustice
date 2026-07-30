import 'package:autth_injustice_app/institution/domain/models/institution_resource.dart';
import 'package:flutter/foundation.dart';

@immutable
class InstitutionBrandingConfig {
  final String appName;
  final String institutionName;
  final String institutionAcronym;
  final String campusId;
  final String campusName;
  final String supportEmail;
  final String? websiteUrl;
  final InstitutionResource logoOnLightBackground;
  final InstitutionResource logoOnDarkBackground;

  const InstitutionBrandingConfig({
    required this.appName,
    required this.institutionName,
    required this.institutionAcronym,
    required this.campusId,
    required this.campusName,
    required this.supportEmail,
    required this.logoOnLightBackground,
    required this.logoOnDarkBackground,
    this.websiteUrl,
  });

  String get institutionWithCampus => '$institutionName • $campusName';
}
