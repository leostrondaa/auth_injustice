import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AppDateTimeFormatter {
  const AppDateTimeFormatter._();

  static String eventDateTime(BuildContext context, DateTime value) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.MMMd(locale).add_Hm().format(value.toLocal());
  }

  static String eventPeriod(
    BuildContext context, {
    required DateTime startsAt,
    DateTime? endsAt,
  }) {
    if (endsAt == null) return eventDateTime(context, startsAt);

    final locale = Localizations.localeOf(context).toLanguageTag();
    final localStart = startsAt.toLocal();
    final localEnd = endsAt.toLocal();
    final sameDay = localStart.year == localEnd.year &&
        localStart.month == localEnd.month &&
        localStart.day == localEnd.day;

    if (sameDay) {
      final start = DateFormat.MMMd(locale).add_Hm().format(localStart);
      final end = DateFormat.Hm(locale).format(localEnd);
      return '$start - $end';
    }

    return '${eventDateTime(context, localStart)} - '
        '${eventDateTime(context, localEnd)}';
  }
}
