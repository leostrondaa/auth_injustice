import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:autth_injustice_app/core/formatters/hours_minutes_formatter.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ComplementaryHoursLinearProgress extends StatelessWidget {
  final ComplementaryHoursSummary summary;
  final double scale;

  const ComplementaryHoursLinearProgress({
    super.key,
    required this.summary,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final milestones = summary.milestoneMinutes.isEmpty
        ? [0, summary.targetMinutes]
        : summary.milestoneMinutes;

    return Semantics(
      label: context.l10n.complementaryHoursProgressSemantics(
        HoursMinutesFormatter.formatMinutes(summary.completedMinutes),
        HoursMinutesFormatter.formatMinutes(summary.targetMinutes),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: summary.progress),
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutCubic,
        builder: (context, progress, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.userDetailsHoursProgress,
                      style: context.text.labelMedium?.copyWith(
                        color: context.onTertiary.withValues(alpha: 0.58),
                        fontSize: 11 * scale,
                      ),
                    ),
                  ),
                  Text(
                    HoursMinutesFormatter.formatMinutes(
                      summary.completedMinutes,
                    ),
                    style: context.titleLarge?.copyWith(
                      color: context.onTertiary,
                      fontSize: 18 * scale,
                    ),
                  ),
                  SizedBox(width: 5 * scale),
                  Text(
                    '/ ${HoursMinutesFormatter.formatMinutes(summary.targetMinutes)}',
                    style: context.bodySmall?.copyWith(
                      color: context.onTertiary.withValues(alpha: 0.42),
                      fontSize: 10.5 * scale,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12 * scale),
              SizedBox(
                height: 18 * scale,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final strokeHeight = 9 * scale;
                    final endpointSize = 13 * scale;
                    final endpointLeft =
                        ((width - endpointSize) * progress).clamp(0.0, width);

                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: strokeHeight,
                          decoration: BoxDecoration(
                            color: context.secondary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(strokeHeight),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: progress,
                            child: Container(
                              height: strokeHeight,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    context.onTertiary,
                                    context.secondary,
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.circular(strokeHeight),
                              ),
                            ),
                          ),
                        ),
                        for (final milestone in milestones)
                          Positioned(
                            left: _positionFor(
                              milestone: milestone,
                              target: summary.targetMinutes,
                              width: width,
                              itemWidth: 2 * scale,
                            ),
                            child: Container(
                              width: 2 * scale,
                              height: 14 * scale,
                              color: context.tertiary.withValues(alpha: 0.55),
                            ),
                          ),
                        if (progress > 0)
                          Positioned(
                            left: endpointLeft,
                            child: Container(
                              width: endpointSize,
                              height: endpointSize,
                              decoration: BoxDecoration(
                                color: context.secondary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: context.secondary.withValues(
                                      alpha: 0.38,
                                    ),
                                    blurRadius: 12 * scale,
                                    spreadRadius: 2 * scale,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 3 * scale),
              SizedBox(
                height: 18 * scale,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final labelWidth = 46 * scale;
                    return Stack(
                      children: [
                        for (final milestone in milestones)
                          Positioned(
                            left: _positionFor(
                              milestone: milestone,
                              target: summary.targetMinutes,
                              width: constraints.maxWidth,
                              itemWidth: labelWidth,
                            ),
                            width: labelWidth,
                            child: Text(
                              '${milestone ~/ Duration.minutesPerHour}h',
                              textAlign: TextAlign.center,
                              style: context.text.labelSmall?.copyWith(
                                color:
                                    context.onTertiary.withValues(alpha: 0.38),
                                fontSize: 8.5 * scale,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static double _positionFor({
    required int milestone,
    required int target,
    required double width,
    required double itemWidth,
  }) {
    if (target <= 0) return 0;
    final ratio = (milestone / target).clamp(0.0, 1.0);
    return ((width - itemWidth) * ratio).clamp(0.0, width - itemWidth);
  }
}
