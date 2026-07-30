import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:equatable/equatable.dart';

class UserDirectoryEntry extends Equatable {
  final Account account;
  final int totalComplementaryMinutes;

  const UserDirectoryEntry({
    required this.account,
    required this.totalComplementaryMinutes,
  }) : assert(totalComplementaryMinutes >= 0);

  String get id => account.uid;
  String get name => account.displayName;
  String get email => account.email;

  UserDirectoryEntry copyWith({
    Account? account,
    int? totalComplementaryMinutes,
  }) {
    return UserDirectoryEntry(
      account: account ?? this.account,
      totalComplementaryMinutes:
          totalComplementaryMinutes ?? this.totalComplementaryMinutes,
    );
  }

  @override
  List<Object?> get props => [account, totalComplementaryMinutes];
}
