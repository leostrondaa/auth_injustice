import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:autth_injustice_app/events/presentation/widgets/events_catalog/event_banner.dart';
import 'package:flutter/material.dart';

class EventImagePreviews extends StatelessWidget {
  final EventPreview event;

  const EventImagePreviews({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PreviewLabel(
          icon: Icons.view_carousel_outlined,
          label: context.l10n.featuredEvents,
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1.295,
          child: EventBanner(
            event: event,
            large: true,
            onTap: () {},
          ),
        ),
        const SizedBox(height: 24),
        _PreviewLabel(
          icon: Icons.view_column_outlined,
          label: context.l10n.futureEvents,
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 170,
            child: AspectRatio(
              aspectRatio: 0.748,
              child: EventBanner(
                event: event,
                large: false,
                onTap: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PreviewLabel({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: context.primary,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: context.text.labelLarge?.copyWith(
            color: context.onTertiary.withValues(alpha: 0.78),
          ),
        ),
      ],
    );
  }
}
