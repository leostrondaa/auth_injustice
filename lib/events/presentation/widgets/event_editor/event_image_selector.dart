import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_action_button.dart';
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/presentation/widgets/event_editor/event_image_catalog.dart';
import 'package:autth_injustice_app/events/presentation/widgets/event_editor/event_image_previews.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_resource.dart';
import 'package:autth_injustice_app/institution/presentation/institution_scope.dart';
import 'package:flutter/material.dart';

class EventImageSelector extends StatelessWidget {
  final EventEditorDraft draft;
  final VoidCallback onPickImage;
  final ValueChanged<InstitutionResource> onSelectPreset;

  const EventImageSelector({
    super.key,
    required this.draft,
    required this.onPickImage,
    required this.onSelectPreset,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = draft.displayImageSource != null;
    final eventsConfig = context.institution.events;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (context.institution.features.eventImageGallery &&
            eventsConfig.presetImages.isNotEmpty) ...[
          Text(
            context.l10n.eventEditorImageGallery,
            style: context.text.titleLarge?.copyWith(
              color: context.onTertiary,
            ),
          ),
          const SizedBox(height: 14),
          EventImageCatalog(
            images: eventsConfig.presetImages,
            selectedSource: draft.selectedImageSource,
            onSelected: onSelectPreset,
          ),
        ],
        if (eventsConfig.allowCustomImageUpload) ...[
          if (eventsConfig.presetImages.isNotEmpty) const SizedBox(height: 20),
          AppActionButton(
            text: context.l10n.eventEditorUseDeviceImage,
            icon: Icons.add_photo_alternate_outlined,
            color: context.primary,
            foregroundColor: context.primary,
            style: AppActionButtonStyle.outlined,
            onPressed: onPickImage,
          ),
        ],
        if (hasImage) ...[
          const SizedBox(height: 28),
          EventImagePreviews(
            event: draft.toDisplayPreview(
              fallbackCategory: context.institution.events.fallbackCategory,
            ),
          ),
        ] else ...[
          const SizedBox(height: 26),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: context.onTertiary.withValues(alpha: 0.035),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.onTertiary.withValues(alpha: 0.11),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.image_outlined,
                size: 52,
                color: context.onTertiary.withValues(alpha: 0.22),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
