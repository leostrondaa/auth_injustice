import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:autth_injustice_app/user_management/domain/models/user_directory_entry.dart';

class ManagedUserDetails {
  final UserDirectoryEntry user;
  final ComplementaryHoursSummary hoursSummary;
  final List<ComplementaryHoursRecord> records;

  ManagedUserDetails({
    required this.user,
    required this.hoursSummary,
    required List<ComplementaryHoursRecord> records,
  }) : records = List.unmodifiable(records);

  ManagedUserDetails copyWith({
    UserDirectoryEntry? user,
    ComplementaryHoursSummary? hoursSummary,
    List<ComplementaryHoursRecord>? records,
  }) {
    return ManagedUserDetails(
      user: user ?? this.user,
      hoursSummary: hoursSummary ?? this.hoursSummary,
      records: records ?? this.records,
    );
  }
}
