import 'package:flutter/foundation.dart';

@immutable
class InstitutionHoursConfig {
  final bool enabled;
  final bool isInformalEstimate;
  final int targetMinutes;
  final List<int> milestoneMinutes;

  const InstitutionHoursConfig({
    required this.enabled,
    required this.isInformalEstimate,
    required this.targetMinutes,
    required this.milestoneMinutes,
  });
}
