import 'package:flutter/foundation.dart';

@immutable
class InstitutionFeaturesConfig {
  final bool map;
  final bool complementaryHours;
  final bool eventManagement;
  final bool eventImageGallery;
  final bool notifications;

  const InstitutionFeaturesConfig({
    required this.map,
    required this.complementaryHours,
    required this.eventManagement,
    required this.eventImageGallery,
    required this.notifications,
  });
}
