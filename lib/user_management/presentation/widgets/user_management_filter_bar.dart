import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/user_management/presentation/viewmodels/user_management_state_viewmodel.dart';
import 'package:flutter/material.dart';

class UserManagementFilterBar extends StatelessWidget {
  final AccountRole? selectedRole;
  final UserSortMode sortMode;
  final ValueChanged<AccountRole?> onSelected;
  final VoidCallback onSortPressed;
  final double horizontalPadding;
  final double scale;
  final double textScale;

  const UserManagementFilterBar({
    super.key,
    required this.selectedRole,
    required this.sortMode,
    required this.onSelected,
    required this.onSortPressed,
    required this.horizontalPadding,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      (label: context.l10n.userManagementFilterAll, role: null),
      (
        label: context.l10n.userManagementFilterStudents,
        role: AccountRole.student,
      ),
      (
        label: context.l10n.userManagementFilterManagers,
        role: AccountRole.eventManager,
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          _SortButton(
            mode: sortMode,
            onTap: onSortPressed,
            scale: scale,
            textScale: textScale,
          ),
          SizedBox(width: 8 * scale),
          for (final filter in filters) ...[
            _UserFilterChip(
              label: filter.label,
              selected: selectedRole == filter.role,
              onTap: () => onSelected(filter.role),
              scale: scale,
              textScale: textScale,
            ),
            SizedBox(width: 8 * scale),
          ],
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final UserSortMode mode;
  final VoidCallback onTap;
  final double scale;
  final double textScale;

  const _SortButton({
    required this.mode,
    required this.onTap,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    final foreground = context.tertiary;

    return Tooltip(
      message: _tooltip(context),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            width: 36 * scale,
            height: 36 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.onTertiary,
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween(begin: 0.65, end: 1.0).animate(animation),
                      child: RotationTransition(
                        turns: Tween(begin: -0.08, end: 0.0).animate(animation),
                        child: child,
                      ),
                    ),
                  );
                },
                child: _SortSymbol(
                  key: ValueKey(mode),
                  mode: mode,
                  color: foreground,
                  scale: scale,
                  textScale: textScale,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _tooltip(BuildContext context) {
    return switch (mode) {
      UserSortMode.nameAscending =>
        context.l10n.userManagementSortNameAscending,
      UserSortMode.nameDescending =>
        context.l10n.userManagementSortNameDescending,
      UserSortMode.hoursDescending =>
        context.l10n.userManagementSortHoursDescending,
      UserSortMode.hoursAscending =>
        context.l10n.userManagementSortHoursAscending,
    };
  }
}

class _SortSymbol extends StatelessWidget {
  final UserSortMode mode;
  final Color color;
  final double scale;
  final double textScale;

  const _SortSymbol({
    super.key,
    required this.mode,
    required this.color,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    return switch (mode) {
      UserSortMode.nameAscending => _letter(context, 'A'),
      UserSortMode.nameDescending => _letter(context, 'Z'),
      UserSortMode.hoursDescending => _hoursSymbol(
          context,
          Icons.arrow_downward_rounded,
        ),
      UserSortMode.hoursAscending => _hoursSymbol(
          context,
          Icons.arrow_upward_rounded,
        ),
    };
  }

  Widget _letter(BuildContext context, String value) {
    return Text(
      value,
      style: context.text.labelLarge?.copyWith(
        color: color,
        fontSize: 13 * textScale,
      ),
    );
  }

  Widget _hoursSymbol(BuildContext context, IconData arrow) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'h',
          style: context.text.labelSmall?.copyWith(
            color: color,
            fontSize: 10 * textScale,
          ),
        ),
        Icon(arrow, size: 11 * scale, color: color),
      ],
    );
  }
}

class _UserFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double scale;
  final double textScale;

  const _UserFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: 15 * scale,
            vertical: 9 * scale,
          ),
          decoration: BoxDecoration(
            color: selected
                ? context.onTertiary
                : context.onTertiary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            label,
            style: context.text.labelMedium?.copyWith(
              color: selected ? context.tertiary : context.onTertiary,
              fontSize: (context.text.labelMedium?.fontSize ?? 12) * textScale,
            ),
          ),
        ),
      ),
    );
  }
}
