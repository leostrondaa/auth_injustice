import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_create_action_card.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventManagementHeader extends StatelessWidget {
  final int eventCount;
  final double height;
  final double horizontalPadding;
  final double scale;
  final double textScale;
  final ValueListenable<double> scrollProgress;
  final VoidCallback onCreate;

  const EventManagementHeader({
    super.key,
    required this.eventCount,
    required this.height,
    required this.horizontalPadding,
    required this.scale,
    required this.textScale,
    required this.scrollProgress,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + (28 * scale),
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 28 * scale,
            child: ColoredBox(color: context.tertiary),
          ),
          Positioned(
            top: height - (4 * scale),
            left: 0,
            right: 0,
            height: 32 * scale,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.tertiary,
                      context.tertiary.withValues(alpha: 0.84),
                      context.tertiary.withValues(alpha: 0),
                    ],
                    stops: const [0, 0.42, 1],
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: scrollProgress,
            builder: (context, progress, child) {
              return Positioned(
                left: 0,
                right: 0,
                bottom: 27 * scale,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: progress,
                    child: Container(
                      height: 1,
                      color: context.onTertiary.withValues(alpha: 0.08),
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              24 * scale,
              horizontalPadding,
              0,
            ),
            child: Column(
              children: [
                AppEntranceTransition(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                context.l10n.eventsTitle,
                                maxLines: 1,
                                style: context.headlineLarge?.copyWith(
                                  color: context.onTertiary,
                                  fontSize: 48 * textScale,
                                ),
                              ),
                            ),
                            SizedBox(height: 6 * scale),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18 * scale),
                AppEntranceTransition(
                  delay: const Duration(milliseconds: 70),
                  child: AppCreateActionCard(
                    scale: scale,
                    textScale: textScale,
                    title: context.l10n.eventManagementCreate,
                    subtitle: context.l10n.eventManagementCreateHint,
                    onTap: onCreate,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
