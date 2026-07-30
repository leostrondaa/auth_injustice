import 'package:equatable/equatable.dart';

class AccountName extends Equatable {
  static const maxPartLength = 80;

  final String firstName;
  final String lastName;

  AccountName({
    required String firstName,
    required String lastName,
  })  : firstName = normalizePart(firstName),
        lastName = normalizePart(lastName);

  factory AccountName.fromDisplayName(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return AccountName(firstName: '', lastName: '');
    }

    return AccountName(
      firstName: parts.first,
      lastName: parts.skip(1).join(' '),
    );
  }

  String get displayName =>
      [firstName, lastName].where((part) => part.isNotEmpty).join(' ');

  bool get hasValidFirstName =>
      firstName.length >= 2 && firstName.length <= maxPartLength;

  bool get hasValidLastName =>
      lastName.length >= 2 && lastName.length <= maxPartLength;

  bool get isComplete => hasValidFirstName && hasValidLastName;

  static String normalizePart(String value) {
    return value.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  @override
  List<Object?> get props => [firstName, lastName];
}
