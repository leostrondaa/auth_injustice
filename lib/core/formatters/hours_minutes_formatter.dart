class HoursMinutes {
  final int hours;
  final int minutes;

  const HoursMinutes({
    required this.hours,
    required this.minutes,
  });

  String get compact => '${hours}h ${minutes}m';
}

abstract final class HoursMinutesFormatter {
  static int toTotalMinutes({required int hours, required int minutes}) {
    if (hours < 0 || minutes < 0 || minutes >= Duration.minutesPerHour) {
      throw ArgumentError('Hours must be positive and minutes must be 0-59.');
    }
    return (hours * Duration.minutesPerHour) + minutes;
  }

  static HoursMinutes splitMinutes(int totalMinutes) {
    final safeMinutes = totalMinutes < 0 ? 0 : totalMinutes;
    return HoursMinutes(
      hours: safeMinutes ~/ Duration.minutesPerHour,
      minutes: safeMinutes % Duration.minutesPerHour,
    );
  }

  static HoursMinutes split(double decimalHours) {
    final safeHours =
        decimalHours.isFinite && decimalHours > 0 ? decimalHours : 0.0;
    final totalMinutes = (safeHours * 60).round();

    return splitMinutes(totalMinutes);
  }

  static String format(double decimalHours) => split(decimalHours).compact;

  static String formatMinutes(int totalMinutes) =>
      splitMinutes(totalMinutes).compact;
}
