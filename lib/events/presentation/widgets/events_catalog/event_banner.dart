import 'package:autth_injustice_app/core/formatters/app_date_time_formatter.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:autth_injustice_app/events/presentation/l10n/event_category_l10n.dart';
import 'package:autth_injustice_app/events/presentation/widgets/common/event_card_visual_style.dart';
import 'package:autth_injustice_app/events/presentation/widgets/common/event_image.dart';
import 'package:flutter/material.dart';

class EventBanner extends StatelessWidget {
  final EventPreview event;
  final VoidCallback onTap;
  final bool large;
  final Color? accentColor;

  const EventBanner({
    super.key,
    required this.event,
    required this.onTap,
    required this.large,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    final effectiveAccent = accentColor ?? context.colors.secondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: EventCardVisualStyle.shadows(
          context,
          accentColor: effectiveAccent,
          scale: context.responsive.layoutScale,
        ),
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                EventImage(
                  source: event.imageUrl,
                  fit: BoxFit.cover,
                  error: ColoredBox(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.image_not_supported_outlined),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(large ? 16 : 12),
                    color: Colors.black.withValues(alpha: 0.62),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.category.localizedLabel(context).toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.70),
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.title,
                          maxLines: large ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: (large
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.labelLarge)
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppDateTimeFormatter.eventDateTime(
                            context,
                            event.startsAt,
                          ),
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.78),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
