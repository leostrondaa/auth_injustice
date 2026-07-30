import 'dart:async';

import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/validation/external_url.dart';
import 'package:autth_injustice_app/core/widgets/app_create_action_card.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:autth_injustice_app/core/widgets/app_status_view.dart';
import 'package:autth_injustice_app/notifications/domain/models/app_notification.dart';
import 'package:autth_injustice_app/notifications/presentation/navigation/notifications_routes.dart';
import 'package:autth_injustice_app/notifications/presentation/viewmodels/notifications/notifications_viewmodel.dart';
import 'package:autth_injustice_app/notifications/presentation/widgets/notifications/notification_card.dart';
import 'package:autth_injustice_app/notifications/presentation/widgets/notifications/notifications_filter_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationsViewModel _viewModel;
  late final AuthorizationService _authorizationService;
  late final ScrollController _scrollController;
  late final ValueNotifier<double> _headerFadeProgress;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<NotificationsViewModel>();
    _authorizationService = injector.get<AuthorizationService>();
    unawaited(
      _viewModel.commands.loadNotifications(),
    );
    _scrollController = ScrollController()..addListener(_updateHeaderFade);
    _headerFadeProgress = ValueNotifier(0);
  }

  void _updateHeaderFade() {
    final progress = (_scrollController.offset / 44).clamp(0.0, 1.0);
    if (_headerFadeProgress.value != progress) {
      _headerFadeProgress.value = progress;
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateHeaderFade)
      ..dispose();
    _headerFadeProgress.dispose();
    super.dispose();
  }

  Future<void> _openAnnouncementEditor() async {
    final published = await context.push<bool>(NotificationsPaths.create);
    if (!mounted || published != true) return;

    await _viewModel.commands.loadNotifications(forceRefresh: true);
  }

  Future<void> _openExternalLink(String value) async {
    final normalized = ExternalUrl.normalize(value);
    if (normalized == null) {
      _showLinkError();
      return;
    }

    try {
      final opened = await launchUrl(
        Uri.parse(normalized),
        mode: LaunchMode.externalApplication,
      );
      if (!opened && mounted) _showLinkError();
    } catch (_) {
      if (mounted) _showLinkError();
    }
  }

  void _showLinkError() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.l10n.notificationOpenLinkError),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final scale = responsive.layoutScale;
    final textScale = responsive.textScale;
    final horizontalPadding = context.extraPagePadding.left;
    final canPublishAnnouncements =
        _authorizationService.canPublishAnnouncements;
    final headerContentHeight = canPublishAnnouncements
        ? (238.0 * scale).clamp(194.0, 256.0)
        : (154.0 * scale).clamp(120.0, 166.0);
    final headerFadeHeight = 54.0 * scale;

    return Scaffold(
      backgroundColor: context.tertiary,
      body: SafeArea(
        bottom: false,
        child: Watch(
          (_) {
            final state = _viewModel.state;
            final notifications = state.visibleNotifications;
            final expandedNotificationId = state.expandedNotificationId.value;
            final isInitialLoading = state.isInitialLoading;
            final hasInitialError = state.hasInitialError;

            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    if (notifications.isEmpty)
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
                                      ? Icons
                                          .signal_wifi_statusbar_connected_no_internet_4_rounded
                                      : Icons.notifications_off_outlined,
                                  title: hasInitialError
                                      ? context.l10n.notificationsLoadErrorTitle
                                      : context.l10n.notificationsEmptyTitle,
                                  message: hasInitialError
                                      ? context
                                          .l10n.notificationsLoadErrorMessage
                                      : context.l10n.notificationsEmptyMessage,
                                  actionLabel: hasInitialError
                                      ? context.l10n.commonRetry
                                      : null,
                                  onAction: hasInitialError
                                      ? () => unawaited(
                                            _viewModel.commands
                                                .loadNotifications(
                                              forceRefresh: true,
                                            ),
                                          )
                                      : null,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding,
                                  ),
                                ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          headerContentHeight + (16 * scale),
                          horizontalPadding,
                          132 * scale,
                        ),
                        sliver: SliverList.separated(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];

                            return NotificationCard(
                              key: ValueKey(notification.id),
                              notification: notification,
                              scale: scale,
                              textScale: textScale,
                              index: index,
                              isExpanded:
                                  expandedNotificationId == notification.id,
                              onTap: () => _viewModel.commands.toggleExpanded(
                                notification.id,
                              ),
                              onExternalLinkTap:
                                  notification.externalUrl == null
                                      ? null
                                      : () => unawaited(
                                            _openExternalLink(
                                              notification.externalUrl!,
                                            ),
                                          ),
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            height: 16 * scale,
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
                  child: _NotificationsHeader(
                    scale: scale,
                    textScale: textScale,
                    horizontalPadding: horizontalPadding,
                    contentHeight: headerContentHeight,
                    fadeHeight: headerFadeHeight,
                    unreadCount: state.unreadCount,
                    selectedType: state.selectedType.value,
                    onFilterSelected: _viewModel.commands.selectFilter,
                    fadeProgress: _headerFadeProgress,
                    canPublishAnnouncements: canPublishAnnouncements,
                    onCreateAnnouncement: () =>
                        unawaited(_openAnnouncementEditor()),
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

class _NotificationsHeader extends StatelessWidget {
  final double scale;
  final double textScale;
  final double horizontalPadding;
  final double contentHeight;
  final double fadeHeight;
  final int unreadCount;
  final AppNotificationType? selectedType;
  final ValueChanged<AppNotificationType?> onFilterSelected;
  final ValueListenable<double> fadeProgress;
  final bool canPublishAnnouncements;
  final VoidCallback onCreateAnnouncement;

  const _NotificationsHeader({
    required this.scale,
    required this.textScale,
    required this.horizontalPadding,
    required this.contentHeight,
    required this.fadeHeight,
    required this.unreadCount,
    required this.selectedType,
    required this.onFilterSelected,
    required this.fadeProgress,
    required this.canPublishAnnouncements,
    required this.onCreateAnnouncement,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: contentHeight,
            width: double.infinity,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppEntranceTransition(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  30 * scale,
                  horizontalPadding,
                  0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          context.l10n.notificationsTitle,
                          maxLines: 1,
                          style: context.displayMedium?.copyWith(
                            color: context.onTertiary,
                            fontSize: 42 * textScale,
                          ),
                        ),
                      ),
                    ),
                    if (unreadCount > 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6 * scale,
                          vertical: 7 * scale,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.error.withValues(
                            alpha: context.isDarkMode ? 0.30 : 0.12,
                          ),
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(
                            color: context.colors.error.withValues(alpha: 0.38),
                          ),
                        ),
                        child: Text(
                          '$unreadCount',
                          style: context.text.labelSmall?.copyWith(
                            color: context.onTertiary,
                            fontSize:
                                (context.text.labelSmall?.fontSize ?? 11) *
                                    textScale,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: (canPublishAnnouncements ? 16 : 28) * scale,
            ),
            AppEntranceTransition(
              delay: Duration(
                milliseconds: canPublishAnnouncements ? 140 : 70,
              ),
              child: NotificationsFilterBar(
                selectedType: selectedType,
                onSelected: onFilterSelected,
                horizontalPadding: horizontalPadding,
                scale: scale,
                textScale: textScale,
              ),
            ),
            SizedBox(
              height: (canPublishAnnouncements ? 16 : 28) * scale,
            ),
            if (canPublishAnnouncements) ...[
              AppEntranceTransition(
                delay: const Duration(milliseconds: 70),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  child: AppCreateActionCard(
                    title: context.l10n.notificationManagementCreate,
                    subtitle: context.l10n.notificationManagementCreateHint,
                    onTap: onCreateAnnouncement,
                    scale: scale,
                    textScale: textScale,
                    icon: Icons.add_alert_rounded,
                  ),
                ),
              ),
              SizedBox(height: 14 * scale),
            ],
          ],
        ),
      ],
    );
  }
}
