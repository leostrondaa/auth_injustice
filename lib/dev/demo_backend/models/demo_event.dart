import 'package:autth_injustice_app/events/domain/models/event_preview.dart';

/// Metadados que o catálogo ainda não exibe, mas que o backend precisa para
/// integrar o histórico pessoal e a estimativa de horas complementares.
class DemoEvent {
  final EventPreview preview;
  final int? complementaryMinutes;

  const DemoEvent({
    required this.preview,
    this.complementaryMinutes,
  }) : assert(complementaryMinutes == null || complementaryMinutes >= 0);
}
