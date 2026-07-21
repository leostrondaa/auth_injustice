import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AppDateTimeFormatter {
  const AppDateTimeFormatter._();

  static String eventDateTime(BuildContext context, DateTime value) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.MMMd(locale).add_Hm().format(value.toLocal());
  }
}
