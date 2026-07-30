import 'dart:math' as math;

import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:autth_injustice_app/core/formatters/hours_minutes_formatter.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/institution/presentation/institution_scope.dart';
import 'package:flutter/material.dart';

class ComplementaryHoursProgressGauge extends StatelessWidget {
  final ComplementaryHoursSummary summary;
  final double height;
  final double scale;

  const ComplementaryHoursProgressGauge({
    super.key,
    required this.summary,
    required this.height,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.complementaryHoursProgressSemantics(
        HoursMinutesFormatter.format(summary.completedHours),
        HoursMinutesFormatter.format(summary.targetHours),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: summary.progress),
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutCubic,
        builder: (context, progress, child) {
          final animatedHours = summary.completedHours;
          final completedTime = HoursMinutesFormatter.split(animatedHours);

          return SizedBox(
            height: height,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _HoursArcPainter(
                      progress: progress,
                      milestones: summary.milestones,
                      targetHours: summary.targetHours,
                      trackColor: context.secondary.withValues(alpha: 0.08),
                      startColor: context.onTertiary,
                      endColor: context.secondary,
                      markerColor: context.onTertiary,
                      labelStyle: context.text.labelSmall?.copyWith(
                            color: context.onTertiary.withValues(alpha: 0.48),
                            fontSize: 10 * scale,
                          ) ??
                          TextStyle(
                            color: context.onTertiary.withValues(alpha: 0.48),
                            fontSize: 10 * scale,
                          ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: height * 0.075,
                  child: _BoundaryLabel(
                    value: 0,
                    scale: scale,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: height * 0.31,
                  width: height * 0.52,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8 * scale),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      context.onTertiary,
                                      context.secondary.withValues(alpha: 1),
                                    ],
                                    stops: const [0.65, 1],
                                  ).createShader(bounds),
                                  child: Text(
                                    completedTime.hours.toString(),
                                    style: context.displayLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 78 * scale,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'h ',
                                style: context.headlineMedium?.copyWith(
                                  color:
                                      context.onTertiary.withValues(alpha: 0.9),
                                  fontSize: 21 * scale,
                                ),
                              ),
                              TextSpan(
                                text: completedTime.minutes.toString(),
                                style: context.displaySmall?.copyWith(
                                  color:
                                      context.onTertiary.withValues(alpha: 0.9),
                                  fontSize: 42 * scale,
                                ),
                              ),
                              TextSpan(
                                text: 'm',
                                style: context.headlineMedium?.copyWith(
                                  color:
                                      context.onTertiary.withValues(alpha: 0.9),
                                  fontSize: 21 * scale,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 7 * scale),
                      Text(
                        context.l10n.complementaryHoursInformalNotice(
                          context.institution.branding.institutionAcronym,
                        ),
                        style: context.bodySmall?.copyWith(
                          color: context.onTertiary.withValues(alpha: 0.52),
                          fontSize: 11 * scale,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: height * 0.075,
                  child: _BoundaryLabel(
                    value: summary.targetHours,
                    scale: scale,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static String _formatHours(double value) {
    if (value == value.roundToDouble()) return value.toInt().toString();
    return value.toStringAsFixed(1).replaceAll('.', '.');
  }
}

class _BoundaryLabel extends StatelessWidget {
  final double value;
  final double scale;

  const _BoundaryLabel({required this.value, required this.scale});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          context.onTertiary.withValues(alpha: 0.3),
          context.onTertiary.withValues(alpha: 0.3),
        ],
        stops: const [0.5, 1],
      ).createShader(bounds),
      child: Text(
        '${ComplementaryHoursProgressGauge._formatHours(value)} h',
        style: context.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: 16 * scale,
        ),
      ),
    );
  }
}

class _HoursArcPainter extends CustomPainter {
  final double progress;
  final List<double> milestones;
  final double targetHours;
  final Color trackColor;
  final Color startColor;
  final Color endColor;
  final Color markerColor;
  final TextStyle labelStyle;

  const _HoursArcPainter({
    required this.progress,
    required this.milestones,
    required this.targetHours,
    required this.trackColor,
    required this.startColor,
    required this.endColor,
    required this.markerColor,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = math.min(size.width * 0.052, 19.0);
    final center = Offset(size.width * 0.30, size.height / 2);
    final radius = math.min(
      size.height * 0.40,
      size.width - center.dx - (strokeWidth * 2.6),
    );
    final arcRect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -math.pi / 2;
    const sweepAngle = math.pi;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, startAngle, sweepAngle, false, trackPaint);

    final progressPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [startColor, endColor],
        stops: const [0, 0.3],
      ).createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      arcRect,
      startAngle,
      sweepAngle * progress,
      false,
      progressPaint,
    );

    _drawIntermediateMilestones(
      canvas: canvas,
      center: center,
      radius: radius,
      strokeWidth: strokeWidth,
      startAngle: startAngle,
      sweepAngle: sweepAngle,
    );

    if (progress > 0) {
      final endAngle = startAngle + (sweepAngle * progress);
      final currentColor = _colorForAngle(endAngle);
      final endpoint =
          center + Offset(math.cos(endAngle), math.sin(endAngle)) * radius;
      final glowPaint = Paint()
        ..color = currentColor.withValues(alpha: 0.40)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, strokeWidth * 0.75);
      canvas.drawCircle(endpoint, strokeWidth * 0.68, glowPaint);
      canvas.drawCircle(
        endpoint,
        strokeWidth * 0.31,
        Paint()..color = currentColor,
      );
    }
  }

  void _drawIntermediateMilestones({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double strokeWidth,
    required double startAngle,
    required double sweepAngle,
  }) {
    if (targetHours <= 0 || milestones.length < 3) return;

    for (final milestone in milestones.skip(1).take(milestones.length - 2)) {
      final ratio = (milestone / targetHours).clamp(0.0, 1.0);
      final angle = startAngle + (sweepAngle * ratio);
      final direction = Offset(math.cos(angle), math.sin(angle));
      final reached = ratio <= progress;
      final color = reached ? _colorForAngle(angle) : markerColor;
      final tickPaint = Paint()
        ..color = color.withValues(alpha: reached ? 0.68 : 0.18)
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        center + direction * (radius - strokeWidth * 0.78),
        center + direction * (radius + strokeWidth * 0.78),
        tickPaint,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: ComplementaryHoursProgressGauge._formatHours(milestone),
          style: labelStyle.copyWith(
            color: color.withValues(alpha: reached ? 0.82 : 0.42),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final labelCenter = center + direction * (radius + strokeWidth * 1.85);
      textPainter.paint(
        canvas,
        labelCenter - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  Color _colorForAngle(double angle) {
    final verticalPosition = ((math.sin(angle) + 1) / 2).clamp(0.0, 1.0);
    return Color.lerp(startColor, endColor, verticalPosition)!;
  }

  @override
  bool shouldRepaint(covariant _HoursArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.milestones != milestones ||
        oldDelegate.targetHours != targetHours ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.startColor != startColor ||
        oldDelegate.endColor != endColor ||
        oldDelegate.markerColor != markerColor ||
        oldDelegate.labelStyle != labelStyle;
  }
}
