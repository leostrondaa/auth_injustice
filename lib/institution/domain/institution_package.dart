import 'package:autth_injustice_app/institution/domain/models/institution_backend_config.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_branding_config.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_events_config.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_features_config.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_hours_config.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_localization_config.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_map_manifest.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_theme_config.dart';

abstract interface class InstitutionPackage {
  String get id;
  String get version;

  InstitutionBrandingConfig get branding;
  InstitutionThemeConfig get theme;
  InstitutionLocalizationConfig get localization;
  InstitutionHoursConfig get complementaryHours;
  InstitutionEventsConfig get events;
  InstitutionMapManifest get map;
  InstitutionBackendConfig get backend;
  InstitutionFeaturesConfig get features;
}
