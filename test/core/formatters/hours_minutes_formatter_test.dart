import 'package:autth_injustice_app/core/formatters/hours_minutes_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HoursMinutesFormatter', () {
    test('converts decimal hours to hours and minutes', () {
      final value = HoursMinutesFormatter.split(50.5);

      expect(value.hours, 50);
      expect(value.minutes, 30);
      expect(value.compact, '50h 30m');
    });

    test('rounds floating point values to the nearest minute', () {
      final value = HoursMinutesFormatter.split(4.75);

      expect(value.hours, 4);
      expect(value.minutes, 45);
    });

    test('converts separate admin fields to total minutes', () {
      final total = HoursMinutesFormatter.toTotalMinutes(
        hours: 4,
        minutes: 30,
      );

      expect(total, 270);
      expect(HoursMinutesFormatter.formatMinutes(total), '4h 30m');
    });
  });
}
