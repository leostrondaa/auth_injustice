import 'dart:async';

import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/viewmodels/records/complementary_hours_records_viewmodel.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/widgets/records/complementary_hours_delete_record_dialog.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/widgets/records/complementary_hours_record_card.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/widgets/records/complementary_hours_records_drawer_handle.dart';
import 'package:autth_injustice_app/complementary_hours/presentation/widgets/records/complementary_hours_records_status.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ComplementaryHoursRecordsDrawer extends StatefulWidget {
  final double scale;
  final VoidCallback onRecordsChanged;

  const ComplementaryHoursRecordsDrawer({
    super.key,
    required this.scale,
    required this.onRecordsChanged,
  });

  @override
  State<ComplementaryHoursRecordsDrawer> createState() =>
      _ComplementaryHoursRecordsDrawerState();
}

class _ComplementaryHoursRecordsDrawerState
    extends State<ComplementaryHoursRecordsDrawer>
    with SingleTickerProviderStateMixin {
  late final ComplementaryHoursRecordsViewModel _viewModel;
  late final DraggableScrollableController _drawerController;
  late final AnimationController _swipeHintController;
  late final Animation<double> _swipeHintAnimation;
  final ValueNotifier<double> _drawerProgress = ValueNotifier(0);

  double _minExtent = 0;
  double _availableHeight = 0;
  Timer? _swipeHintTimer;
  bool _swipeHintScheduled = false;
  bool _swipeHintShownForCurrentOpening = false;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<ComplementaryHoursRecordsViewModel>();
    _drawerController = DraggableScrollableController()
      ..addListener(_updateDrawerProgress);
    _swipeHintController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _swipeHintAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.easeOutCubic),
        ),
        weight: 30,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(1), weight: 40),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0).chain(
          CurveTween(curve: Curves.easeInOutCubic),
        ),
        weight: 30,
      ),
    ]).animate(_swipeHintController);
    unawaited(_viewModel.commands.loadRecords(forceRefresh: true));
  }

  void _updateDrawerProgress() {
    if (!_drawerController.isAttached || _minExtent == 0) return;

    final progress = ((_drawerController.size - _minExtent) / (1 - _minExtent))
        .clamp(0.0, 1.0);
    if (_drawerProgress.value != progress) {
      _drawerProgress.value = progress;
    }

    if (progress >= 0.96) {
      _scheduleSwipeHintIfNeeded();
    } else if (progress < 0.75) {
      _cancelSwipeHint(resetForNextOpening: true);
    }
  }

  void _scheduleSwipeHintIfNeeded() {
    if (_swipeHintShownForCurrentOpening ||
        _swipeHintScheduled ||
        _drawerProgress.value < 0.96 ||
        _viewModel.state.records.value.isEmpty) {
      return;
    }

    _swipeHintScheduled = true;
    _swipeHintShownForCurrentOpening = true;
    _swipeHintTimer = Timer(const Duration(milliseconds: 180), () async {
      if (!mounted || _drawerProgress.value < 0.96) {
        _swipeHintScheduled = false;
        _swipeHintShownForCurrentOpening = false;
        return;
      }

      await _swipeHintController.forward(from: 0);
    });
  }

  void _cancelSwipeHint({required bool resetForNextOpening}) {
    _swipeHintTimer?.cancel();
    _swipeHintTimer = null;

    if (_swipeHintController.isAnimating || _swipeHintController.value != 0) {
      _swipeHintController
        ..stop()
        ..reset();
    }

    _swipeHintScheduled = false;
    if (resetForNextOpening) {
      _swipeHintShownForCurrentOpening = false;
    }
  }

  void _updateDrawerFromDrag(DragUpdateDetails details) {
    if (!_drawerController.isAttached || _availableHeight == 0) return;

    if (_drawerProgress.value >= 0.96) {
      _cancelSwipeHint(resetForNextOpening: false);
    }

    final nextSize = (_drawerController.size -
            (details.primaryDelta ?? 0) / _availableHeight)
        .clamp(_minExtent, 1.0);
    _drawerController.jumpTo(nextSize);
  }

  void _finishDrawerDrag(DragEndDetails details) {
    if (!_drawerController.isAttached) return;

    final velocity = details.primaryVelocity ?? 0;
    final shouldOpen = velocity < -320 ||
        (velocity <= 320 &&
            velocity >= -320 &&
            _drawerController.size > (_minExtent + 1) / 2);

    unawaited(_animateDrawer(shouldOpen ? 1 : _minExtent));
  }

  Future<void> _toggleDrawer() async {
    if (!_drawerController.isAttached) return;

    final isMostlyOpen = _drawerController.size > (_minExtent + 1) / 2;
    await _animateDrawer(isMostlyOpen ? _minExtent : 1);
  }

  Future<void> _animateDrawer(double extent) {
    return _drawerController.animateTo(
      extent,
      duration: const Duration(milliseconds: 430),
      curve: Curves.easeOutCubic,
    );
  }

  Future<bool> _confirmDelete(ComplementaryHoursRecord record) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => ComplementaryHoursDeleteRecordDialog(
            record: record,
            onCancel: () => Navigator.of(dialogContext).pop(false),
            onConfirm: () => Navigator.of(dialogContext).pop(true),
          ),
        ) ??
        false;

    if (!confirmed || !mounted) return false;

    final deleted = await _viewModel.commands.deleteRecord(record.id);
    if (!mounted) return false;

    if (!deleted) {
      final message = _viewModel.state.errorMessage.value ??
          context.l10n.complementaryHoursDeleteError;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }

    return deleted;
  }

  void _completeDismissal(String recordId) {
    _viewModel.commands.completeDismissal(recordId);
    widget.onRecordsChanged();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.l10n.complementaryHoursDeleted),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  void dispose() {
    _swipeHintTimer?.cancel();
    _drawerController
      ..removeListener(_updateDrawerProgress)
      ..dispose();
    _swipeHintController.dispose();
    _drawerProgress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final handleHeight = 58.0 * widget.scale;
        _availableHeight = constraints.maxHeight;
        _minExtent = (handleHeight / constraints.maxHeight).clamp(0.06, 0.16);

        return DraggableScrollableSheet(
          controller: _drawerController,
          initialChildSize: _minExtent,
          minChildSize: _minExtent,
          maxChildSize: 1,
          snap: true,
          snapSizes: [_minExtent, 1],
          snapAnimationDuration: const Duration(milliseconds: 430),
          shouldCloseOnMinExtent: false,
          builder: (context, scrollController) {
            return ValueListenableBuilder<double>(
              valueListenable: _drawerProgress,
              builder: (context, progress, child) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.tertiary.withValues(alpha: progress),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28 * widget.scale),
                    ),
                    border: Border(
                      top: BorderSide(
                        color: context.onTertiary.withValues(
                          alpha: 0.1 * progress,
                        ),
                      ),
                    ),
                    boxShadow: progress == 0
                        ? const []
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.14 * progress,
                              ),
                              blurRadius: 28,
                              offset: const Offset(0, -10),
                            ),
                          ],
                  ),
                  child: child,
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: handleHeight,
                    child: Center(
                      child: ComplementaryHoursRecordsDrawerHandle(
                        scale: widget.scale,
                        progress: _drawerProgress,
                        onTap: _toggleDrawer,
                        onVerticalDragUpdate: _updateDrawerFromDrag,
                        onVerticalDragEnd: _finishDrawerDrag,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Watch(
                      (_) {
                        final state = _viewModel.state;
                        final records = state.records.value;

                        if (records.isNotEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) _scheduleSwipeHintIfNeeded();
                          });
                        }

                        return Stack(
                          children: [
                            CustomScrollView(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              slivers: [
                                if (records.isEmpty)
                                  SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: ComplementaryHoursRecordsStatus(
                                      loading: state.loading.value,
                                      errorMessage: state.errorMessage.value,
                                      scale: widget.scale,
                                      onRetry: () => unawaited(
                                        _viewModel.commands.loadRecords(
                                          forceRefresh: true,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  SliverPadding(
                                    padding: EdgeInsets.fromLTRB(
                                      context.extraPagePadding.left,
                                      18 * widget.scale,
                                      context.extraPagePadding.right,
                                      28 * widget.scale,
                                    ),
                                    sliver: SliverList.separated(
                                      itemCount: records.length,
                                      itemBuilder: (context, index) {
                                        final record = records[index];

                                        return ComplementaryHoursRecordCard(
                                          key: ValueKey(record.id),
                                          record: record,
                                          scale: widget.scale,
                                          index: index,
                                          swipeHintAnimation: index == 0
                                              ? _swipeHintAnimation
                                              : null,
                                          onSwipeStarted: () =>
                                              _cancelSwipeHint(
                                            resetForNextOpening: false,
                                          ),
                                          onConfirmDelete: () =>
                                              _confirmDelete(record),
                                          onDismissed: () =>
                                              _completeDismissal(record.id),
                                        );
                                      },
                                      separatorBuilder: (_, __) => SizedBox(
                                        height: 14 * widget.scale,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              height: 30 * widget.scale,
                              child: IgnorePointer(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        context.tertiary,
                                        context.tertiary.withValues(alpha: 0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
