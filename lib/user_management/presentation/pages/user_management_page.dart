import 'dart:async';

import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_back_button.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:autth_injustice_app/core/widgets/app_status_view.dart';
import 'package:autth_injustice_app/core/widgets/inputs/app_search_field.dart';
import 'package:autth_injustice_app/user_management/presentation/viewmodels/user_management_viewmodel.dart';
import 'package:autth_injustice_app/user_management/presentation/viewmodels/user_management_state_viewmodel.dart';
import 'package:autth_injustice_app/user_management/presentation/navigation/user_management_routes.dart';
import 'package:autth_injustice_app/user_management/presentation/widgets/user_management_card.dart';
import 'package:autth_injustice_app/user_management/presentation/widgets/user_management_filter_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  late final UserManagementViewModel _viewModel;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final ValueNotifier<double> _headerFadeProgress;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<UserManagementViewModel>();
    _searchController = TextEditingController();
    _scrollController = ScrollController()..addListener(_updateHeaderFade);
    _headerFadeProgress = ValueNotifier(0);
    _viewModel.commands.resetFilters();
    unawaited(_viewModel.commands.loadUsers());
  }

  void _updateHeaderFade() {
    final progress = (_scrollController.offset / 44).clamp(0.0, 1.0);
    if (_headerFadeProgress.value != progress) {
      _headerFadeProgress.value = progress;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController
      ..removeListener(_updateHeaderFade)
      ..dispose();
    _headerFadeProgress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final scale = responsive.layoutScale;
    final textScale = responsive.textScale;
    final horizontalPadding = context.extraPagePadding.left;
    final headerContentHeight = (282.0 * scale).clamp(236.0, 310.0).toDouble();
    final headerFadeHeight = (54.0 * scale).clamp(42.0, 62.0).toDouble();

    return Scaffold(
      backgroundColor: context.tertiary,
      body: SafeArea(
        bottom: false,
        child: Watch(
          (_) {
            final state = _viewModel.state;
            final users = state.visibleUsers;
            final isInitialLoading = state.isInitialLoading;
            final hasInitialError = state.hasInitialError;
            final hasActiveFilter = state.selectedRole.value != null ||
                state.searchQuery.value.trim().isNotEmpty;

            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    if (users.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: headerContentHeight,
                          ),
                          child: isInitialLoading
                              ? const AppStatusView.loading()
                              : AppStatusView(
                                  icon: hasInitialError
                                      ? Icons.cloud_off_outlined
                                      : Icons.person_search_outlined,
                                  title: hasInitialError
                                      ? context.l10n.userManagementLoadError
                                      : hasActiveFilter
                                          ? context.l10n.userManagementNoResults
                                          : context.l10n.userManagementEmpty,
                                  actionLabel: hasInitialError
                                      ? context.l10n.commonRetry
                                      : null,
                                  onAction: hasInitialError
                                      ? () => unawaited(
                                            _viewModel.commands.loadUsers(
                                              forceRefresh: true,
                                            ),
                                          )
                                      : null,
                                ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          headerContentHeight + (18 * scale),
                          horizontalPadding,
                          36 * scale,
                        ),
                        sliver: SliverList.separated(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];

                            return UserManagementCard(
                              key: ValueKey(user.id),
                              user: user,
                              scale: scale,
                              textScale: textScale,
                              index: index,
                              onTap: () async {
                                await context.pushNamed(
                                  UserManagementRouteNames.details,
                                  pathParameters: {'userId': user.id},
                                );
                                if (!mounted) return;
                                unawaited(
                                  _viewModel.commands.loadUsers(
                                    forceRefresh: true,
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (_, __) =>
                              SizedBox(height: 13 * scale),
                        ),
                      ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: headerContentHeight + headerFadeHeight,
                  child: _UserManagementHeader(
                    searchController: _searchController,
                    selectedRole: state.selectedRole.value,
                    sortMode: state.sortMode.value,
                    scale: scale,
                    textScale: textScale,
                    horizontalPadding: horizontalPadding,
                    contentHeight: headerContentHeight,
                    fadeHeight: headerFadeHeight,
                    fadeProgress: _headerFadeProgress,
                    onSearchChanged: _viewModel.commands.search,
                    onRoleSelected: _viewModel.commands.selectRole,
                    onSortPressed: _viewModel.commands.cycleSort,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _UserManagementHeader extends StatelessWidget {
  final TextEditingController searchController;
  final AccountRole? selectedRole;
  final UserSortMode sortMode;
  final double scale;
  final double textScale;
  final double horizontalPadding;
  final double contentHeight;
  final double fadeHeight;
  final ValueListenable<double> fadeProgress;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<AccountRole?> onRoleSelected;
  final VoidCallback onSortPressed;

  const _UserManagementHeader({
    required this.searchController,
    required this.selectedRole,
    required this.sortMode,
    required this.scale,
    required this.textScale,
    required this.horizontalPadding,
    required this.contentHeight,
    required this.fadeHeight,
    required this.fadeProgress,
    required this.onSearchChanged,
    required this.onRoleSelected,
    required this.onSortPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: double.infinity,
            height: contentHeight,
            child: ColoredBox(color: context.tertiary),
          ),
        ),
        Positioned(
          top: contentHeight - 16,
          left: 0,
          right: 0,
          height: fadeHeight + 16,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  8 * scale,
                  horizontalPadding,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppEntranceTransition(
                      child: AppBackButton(
                        onPressed: context.pop,
                        iconSize: 25 * scale,
                        foregroundColor: context.onTertiary,
                      ),
                    ),
                    SizedBox(height: 10 * scale),
                    AppEntranceTransition(
                      delay: const Duration(milliseconds: 45),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          context.l10n.userManagementTitle,
                          maxLines: 1,
                          style: context.displayLarge?.copyWith(
                            color: context.onTertiary,
                            fontSize: 48 * textScale,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * scale),
                    AppEntranceTransition(
                      delay: const Duration(milliseconds: 80),
                      child: AppSearchField(
                        controller: searchController,
                        hintText: context.l10n.userManagementSearchHint,
                        onChanged: onSearchChanged,
                      ),
                    ),
                    SizedBox(height: 16 * scale),
                  ],
                ),
              ),
              AppEntranceTransition(
                delay: const Duration(milliseconds: 115),
                child: UserManagementFilterBar(
                  selectedRole: selectedRole,
                  sortMode: sortMode,
                  onSelected: onRoleSelected,
                  onSortPressed: onSortPressed,
                  horizontalPadding: horizontalPadding,
                  scale: scale,
                  textScale: textScale,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
