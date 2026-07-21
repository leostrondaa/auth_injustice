class ComplementaryHoursSummary {
  final int completedMinutes;
  final int targetMinutes;
  final List<int> milestoneMinutes;

  const ComplementaryHoursSummary({
    required this.completedMinutes,
    required this.targetMinutes,
    required this.milestoneMinutes,
  })  : assert(completedMinutes >= 0),
        assert(targetMinutes >= 0);

  double get completedHours => completedMinutes / Duration.minutesPerHour;

  double get targetHours => targetMinutes / Duration.minutesPerHour;

  List<double> get milestones => List.unmodifiable(
        milestoneMinutes.map(
          (minutes) => minutes / Duration.minutesPerHour,
        ),
      );

  double get progress {
    if (targetMinutes <= 0) return 0;
    return (completedMinutes / targetMinutes).clamp(0.0, 1.0);
  }

  double get remainingHours {
    return remainingMinutes / Duration.minutesPerHour;
  }

  int get remainingMinutes =>
      (targetMinutes - completedMinutes).clamp(0, targetMinutes);
}
