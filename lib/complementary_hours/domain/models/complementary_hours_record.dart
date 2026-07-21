class ComplementaryHoursRecord {
  /// Identificador único do registro da conta.
  ///
  /// Para atividades adicionadas ao histórico pessoal, usar o ID do evento
  /// torna a gravação no Firestore idempotente e evita registros duplicados.
  final String id;
  final String eventName;
  final DateTime eventDate;

  /// Workload stored as integer minutes. `null` keeps the activity in the
  /// personal history without contributing to the informal estimate.
  final int? durationMinutes;

  const ComplementaryHoursRecord({
    required this.id,
    required this.eventName,
    required this.eventDate,
    this.durationMinutes,
  }) : assert(durationMinutes == null || durationMinutes >= 0);

  double? get hours => switch (durationMinutes) {
        final minutes? => minutes / Duration.minutesPerHour,
        null => null,
      };
}
