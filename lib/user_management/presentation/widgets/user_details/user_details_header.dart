import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/widgets/summary/complementary_hours_linear_progress.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_action_button.dart';
import 'package:autth_injustice_app/core/widgets/app_back_button.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:autth_injustice_app/user_management/domain/models/managed_user_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserDetailsHeader extends StatelessWidget {
  final ManagedUserDetails details;
  final double scale;
  final double textScale;
  final double horizontalPadding;
  final double contentHeight;
  final double fadeHeight;
  final ValueListenable<double> fadeProgress;
  final bool promoting;
  final bool demoting;
  final VoidCallback onBack;
  final VoidCallback? onPromote;
  final VoidCallback? onDemote;

  const UserDetailsHeader({
    super.key,
    required this.details,
    required this.scale,
    required this.textScale,
    required this.horizontalPadding,
    required this.contentHeight,
    required this.fadeHeight,
    required this.fadeProgress,
    required this.promoting,
    required this.demoting,
    required this.onBack,
    required this.onPromote,
    required this.onDemote,
  });

  @override
  Widget build(BuildContext context) {
    final user = details.user;
    final account = user.account;
    final isManager = account.role == AccountRole.eventManager;
    final displayName =
        user.name.trim().isEmpty ? user.email : user.name.trim();

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: contentHeight,
          child: ColoredBox(color: context.tertiary),
        ),
        Positioned(
          top: contentHeight - 10,
          left: 0,
          right: 0,
          height: fadeHeight + 10,
          child: IgnorePointer(
            child: ValueListenableBuilder<double>(
              valueListenable: fadeProgress,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          context.tertiary,
                          context.tertiary.withValues(alpha: 0.82),
                          context.tertiary.withValues(alpha: 0),
                        ],
                        stops: const [0, 0.45, 1],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: contentHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppEntranceTransition(
                  child: Row(
                    children: [
                      AppBackButton(
                        onPressed: onBack,
                        iconSize: 25 * scale,
                        foregroundColor: context.onTertiary,
                      ),
                      SizedBox(width: 4 * scale),
                      Expanded(
                        child: Text(
                          context.l10n.userDetailsTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.titleLarge?.copyWith(
                            color: context.onTertiary,
                            fontSize: 20 * textScale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6 * scale),
                AppEntranceTransition(
                  delay: const Duration(milliseconds: 45),
                  child: Row(
                    children: [
                      _UserInitials(
                        firstName: account.firstName,
                        lastName: account.lastName,
                        fallback: user.email,
                        scale: scale,
                        textScale: textScale,
                      ),
                      SizedBox(width: 14 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleLarge?.copyWith(
                                color: context.onTertiary,
                                fontSize: 18 * textScale,
                              ),
                            ),
                            SizedBox(height: 3 * scale),
                            Text(
                              user.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.bodySmall?.copyWith(
                                color: context.onTertiary.withValues(
                                  alpha: 0.52,
                                ),
                                fontSize: 11 * textScale,
                              ),
                            ),
                            SizedBox(height: 6 * scale),
                            _RolePill(
                              isManager: isManager,
                              scale: scale,
                              textScale: textScale,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8 * scale),
                      AppEntranceTransition(
                        delay: const Duration(milliseconds: 125),
                        child: SizedBox(
                          width: (100 * scale).clamp(90.0, 132.0).toDouble(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: AppActionButton(
                                  text: context.l10n.userDetailsPromote,
                                  icon: Icons.arrow_upward_rounded,
                                  color: context.secondary,
                                  foregroundColor: context.onSecondary,
                                  height:
                                      (35 * scale).clamp(25.0, 42.0).toDouble(),
                                  isLoading: promoting,
                                  onPressed: onPromote,
                                ),
                              ),
                              SizedBox(height: 10 * scale),
                              SizedBox(
                                width: double.infinity,
                                child: AppActionButton(
                                  text: context.l10n.userDetailsDemote,
                                  icon: Icons.arrow_downward_rounded,
                                  color: context.colors.error,
                                  foregroundColor: context.colors.error,
                                  style: AppActionButtonStyle.outlined,
                                  height:
                                      (35 * scale).clamp(25.0, 42.0).toDouble(),
                                  isLoading: demoting,
                                  onPressed: onDemote,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50 * scale),
                AppEntranceTransition(
                  delay: const Duration(milliseconds: 85),
                  child: ComplementaryHoursLinearProgress(
                    summary: details.hoursSummary,
                    scale: scale,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UserInitials extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String fallback;
  final double scale;
  final double textScale;

  const _UserInitials({
    required this.firstName,
    required this.lastName,
    required this.fallback,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    final initials = [
      if (firstName.isNotEmpty) firstName.characters.first,
      if (lastName.isNotEmpty) lastName.characters.first,
    ].join();
    final label = initials.isNotEmpty
        ? initials.toUpperCase()
        : fallback.characters.first.toUpperCase();

    return Container(
      width: 52 * scale,
      height: 52 * scale,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.secondary.withValues(alpha: 0.12),
        border: Border.all(
          color: context.secondary.withValues(alpha: 0.28),
        ),
      ),
      child: Text(
        label,
        style: context.titleLarge?.copyWith(
          color: context.secondary,
          fontSize: 17 * textScale,
        ),
      ),
    );
  }
}

class _RolePill extends StatelessWidget {
  final bool isManager;
  final double scale;
  final double textScale;

  const _RolePill({
    required this.isManager,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 9 * scale,
          vertical: 4 * scale,
        ),
        decoration: BoxDecoration(
          color: context.secondary.withValues(
            alpha: context.isDarkMode ? 0.18 : 0.09,
          ),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          isManager
              ? context.l10n.userManagementRoleEventManager
              : context.l10n.userManagementRoleStudent,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.text.labelSmall?.copyWith(
            color: context.onTertiary.withValues(alpha: 0.82),
            fontSize: 9 * textScale,
          ),
        ),
      ),
    );
  }
}
