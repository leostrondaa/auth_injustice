import 'dart:async';

import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:autth_injustice_app/notifications/domain/models/app_notification.dart';
import 'package:autth_injustice_app/notifications/presentation/viewmodels/notifications/notifications_viewmodel.dart';
import 'package:autth_injustice_app/notifications/presentation/widgets/notifications/notification_card.dart';
import 'package:autth_injustice_app/notifications/presentation/widgets/notifications/notifications_filter_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationsViewModel _viewModel;
  late final ScrollController _scrollController;
  late final ValueNotifier<double> _headerFadeProgress;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<NotificationsViewModel>();
    unawaited(
      _viewModel.commands.loadNotifications(forceRefresh: true),
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

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final scale = responsive.layoutScale;
    final textScale = responsive.textScale;
    final horizontalPadding = context.extraPagePadding.left;
    final headerContentHeight = (154.0 * scale).clamp(120.0, 166.0);
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
            final isLoading = state.loading.value;
            final errorMessage = state.errorMessage.value;

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
                          child: _NotificationsStatus(
                            isLoading: isLoading,
                            errorMessage: errorMessage,
                            scale: scale,
                            textScale: textScale,
                            horizontalPadding: horizontalPadding,
                            onRetry: () => unawaited(
                              _viewModel.commands.loadNotifications(
                                forceRefresh: true,
                              ),
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

class _NotificationsStatus extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final double scale;
  final double textScale;
  final double horizontalPadding;
  final VoidCallback onRetry;

  const _NotificationsStatus({
    required this.isLoading,
    required this.errorMessage,
    required this.scale,
    required this.textScale,
    required this.horizontalPadding,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 30 * scale,
          height: 30 * scale,
          child: CircularProgressIndicator(
            strokeWidth: 2.5 * scale,
            color: context.onTertiary,
          ),
        ),
      );
    }

    final hasError = errorMessage != null;
    final title = hasError
        ? context.l10n.notificationsLoadErrorTitle
        : context.l10n.notificationsEmptyTitle;
    final message = hasError
        ? context.l10n.notificationsLoadErrorMessage
        : context.l10n.notificationsEmptyMessage;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasError
                  ? Icons.signal_wifi_statusbar_connected_no_internet_4_rounded
                  : Icons.notifications_off_outlined,
              size: 46 * scale,
              color: context.onTertiary.withValues(alpha: 0.42),
            ),
            SizedBox(height: 14 * scale),
            Text(
              title,
              style: context.titleLarge?.copyWith(
                color: context.onTertiary,
                fontSize: (context.titleLarge?.fontSize ?? 18) * textScale,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6 * scale),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.bodySmall?.copyWith(
                color: context.onTertiary.withValues(alpha: 0.62),
                fontSize: (context.bodySmall?.fontSize ?? 12) * textScale,
              ),
            ),
            if (hasError) ...[
              SizedBox(height: 18 * scale),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(context.l10n.commonRetry),
                style: TextButton.styleFrom(
                  foregroundColor: context.onTertiary,
                ),
              ),
            ],
          ],
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
            SizedBox(height: 28 * scale),
            AppEntranceTransition(
              delay: const Duration(milliseconds: 70),
              child: NotificationsFilterBar(
                selectedType: selectedType,
                onSelected: onFilterSelected,
                horizontalPadding: horizontalPadding,
                scale: scale,
                textScale: textScale,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
