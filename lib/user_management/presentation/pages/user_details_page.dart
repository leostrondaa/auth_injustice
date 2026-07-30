import 'dart:async';

import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/widgets/records/complementary_hours_record_card.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:autth_injustice_app/core/widgets/app_status_view.dart';
import 'package:autth_injustice_app/user_management/presentation/viewmodels/user_details/user_details_viewmodel.dart';
import 'package:autth_injustice_app/user_management/presentation/widgets/user_details/user_details_header.dart';
import 'package:autth_injustice_app/user_management/presentation/widgets/user_details/user_role_change_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

class UserDetailsPage extends StatefulWidget {
  final String userId;

  const UserDetailsPage({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late final UserDetailsViewModel _viewModel;
  late final ScrollController _scrollController;
  late final ValueNotifier<double> _headerFadeProgress;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<UserDetailsViewModel>();
    _viewModel.state.reset();
    _scrollController = ScrollController()..addListener(_updateHeaderFade);
    _headerFadeProgress = ValueNotifier(0);
    unawaited(_viewModel.commands.load(widget.userId));
  }

  void _updateHeaderFade() {
    final progress = (_scrollController.offset / 42).clamp(0.0, 1.0);
    if (_headerFadeProgress.value != progress) {
      _headerFadeProgress.value = progress;
    }
  }

  Future<void> _requestRoleChange(AccountRole role) async {
    final details = _viewModel.state.details.value;
    if (details == null) return;

    final displayName = details.user.name.trim().isEmpty
        ? details.user.email
        : details.user.name.trim();
    final confirmed = await showUserRoleChangeDialog(
      context: context,
      userName: displayName,
      targetRole: role,
    );
    if (!confirmed || !mounted) return;

    final updated = await _viewModel.commands.updateRole(role);
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            updated
                ? context.l10n.userDetailsRoleUpdated
                : context.l10n.userDetailsRoleChangeError,
          ),
        ),
      );
  }

  @override
  void dispose() {
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
    final headerContentHeight = (290.0 * scale).clamp(245.0, 330.0).toDouble();
    final headerFadeHeight = (54.0 * scale).clamp(42.0, 62.0).toDouble();

    return Scaffold(
      backgroundColor: context.tertiary,
      body: SafeArea(
        bottom: false,
        child: Watch(
          (_) {
            final state = _viewModel.state;
            final details = state.details.value;

            if (details == null) {
              if (state.loading.value) {
                return const AppStatusView.loading();
              }

              return AppStatusView(
                icon: Icons.person_off_outlined,
                title: context.l10n.userDetailsLoadError,
                actionLabel: context.l10n.commonRetry,
                onAction: () => unawaited(
                  _viewModel.commands.load(widget.userId),
                ),
              );
            }

            final records = details.records;
            final currentRole = details.user.account.role;
            final pendingRole = state.pendingRole.value;
            final changingRole = state.updatingRole.value;

            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        headerContentHeight + (18 * scale),
                        horizontalPadding,
                        12 * scale,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: AppEntranceTransition(
                          delay: const Duration(milliseconds: 150),
                          child: Text(
                            context.l10n.userDetailsRecordsTitle,
                            style: context.headlineSmall?.copyWith(
                              color: context.onTertiary,
                              fontSize: 25 * textScale,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (records.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 40 * scale,
                          ),
                          child: AppStatusView(
                            icon: Icons.event_note_outlined,
                            title: context.l10n.userDetailsRecordsEmpty,
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          4 * scale,
                          horizontalPadding,
                          36 * scale,
                        ),
                        sliver: SliverList.separated(
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            final record = records[index];

                            return ComplementaryHoursRecordCard(
                              key: ValueKey(record.id),
                              record: record,
                              scale: scale,
                              index: index,
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            height: 14 * scale,
                          ),
                        ),
                      ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: headerContentHeight + headerFadeHeight,
                  child: UserDetailsHeader(
                    details: details,
                    scale: scale,
                    textScale: textScale,
                    horizontalPadding: horizontalPadding,
                    contentHeight: headerContentHeight,
                    fadeHeight: headerFadeHeight,
                    fadeProgress: _headerFadeProgress,
                    promoting:
                        changingRole && pendingRole == AccountRole.eventManager,
                    demoting:
                        changingRole && pendingRole == AccountRole.student,
                    onBack: context.pop,
                    onPromote:
                        !changingRole && currentRole == AccountRole.student
                            ? () => unawaited(
                                  _requestRoleChange(
                                    AccountRole.eventManager,
                                  ),
                                )
                            : null,
                    onDemote:
                        !changingRole && currentRole == AccountRole.eventManager
                            ? () => unawaited(
                                  _requestRoleChange(AccountRole.student),
                                )
                            : null,
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
