import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_action_button.dart';
import 'package:autth_injustice_app/events/presentation/widgets/common/event_image.dart';
import 'package:autth_injustice_app/institution/domain/models/institution_resource.dart';
import 'package:flutter/material.dart';

class EventImageCatalog extends StatefulWidget {
  final List<InstitutionResource> images;
  final String? selectedSource;
  final ValueChanged<InstitutionResource> onSelected;

  const EventImageCatalog({
    super.key,
    required this.images,
    required this.selectedSource,
    required this.onSelected,
  });

  @override
  State<EventImageCatalog> createState() => _EventImageCatalogState();
}

class _EventImageCatalogState extends State<EventImageCatalog> {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final columns = responsive.width >= 600 ? 3 : 2;
    final gap = responsive.scaled(10, min: 8, max: 12);
    final canExpand = widget.images.length > columns;

    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth =
            (constraints.maxWidth - (gap * (columns - 1))) / columns;
        final tileHeight = tileWidth / 1.48;
        final rowCount = (widget.images.length / columns).ceil();
        final gridHeight =
            (rowCount * tileHeight) + ((rowCount - 1).clamp(0, rowCount) * gap);
        final toggleSpace = responsive.scaled(52, min: 48, max: 56);
        final collapsedPeek = responsive.scaled(54, min: 46, max: 62);
        final visibleGridHeight = _expanded || !canExpand
            ? gridHeight
            : tileHeight + gap + collapsedPeek;
        final catalogHeight = visibleGridHeight + (canExpand ? toggleSpace : 0);

        return AnimatedSize(
          duration: const Duration(milliseconds: 340),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: SizedBox(
            key: const ValueKey('event-image-catalog-viewport'),
            height: catalogHeight,
            child: ClipRect(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    height: gridHeight,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: gap,
                        mainAxisSpacing: gap,
                        childAspectRatio: 1.48,
                      ),
                      itemBuilder: (context, index) {
                        final image = widget.images[index];
                        return _EventImageCatalogTile(
                          key: ValueKey('event-image-preset-$index'),
                          image: image,
                          index: index,
                          selected: widget.selectedSource == image.location,
                          onSelected: () => widget.onSelected(image),
                          onExpand: () async {
                            final selected = await showEventImageViewer(
                              context: context,
                              image: image,
                              selected: widget.selectedSource == image.location,
                            );
                            if (selected == true) {
                              widget.onSelected(image);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  if (canExpand)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: toggleSpace + collapsedPeek,
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 180),
                          opacity: _expanded ? 0 : 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  context.tertiary.withValues(alpha: 0),
                                  context.tertiary.withValues(alpha: 0.88),
                                  context.tertiary,
                                ],
                                stops: const [0, 0.52, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (canExpand)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 2,
                      child: Center(
                        child: IconButton(
                          key: const ValueKey('event-image-catalog-toggle'),
                          tooltip: _expanded
                              ? context.l10n.eventEditorCollapseGallery
                              : context.l10n.eventEditorExpandGallery,
                          onPressed: _toggleExpanded,
                          style: IconButton.styleFrom(
                            backgroundColor: context.onTertiary,
                            foregroundColor: context.tertiary,
                            minimumSize: const Size.square(42),
                            shadowColor: Colors.black.withValues(alpha: 0.24),
                            elevation: 5,
                          ),
                          icon: AnimatedRotation(
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOutCubic,
                            turns: _expanded ? 0.5 : 0,
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EventImageCatalogTile extends StatelessWidget {
  final InstitutionResource image;
  final int index;
  final bool selected;
  final VoidCallback onSelected;
  final VoidCallback onExpand;

  const _EventImageCatalogTile({
    super.key,
    required this.image,
    required this.index,
    required this.selected,
    required this.onSelected,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(8);
    final label = context.l10n.eventEditorGalleryImage(index + 1);

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: AnimatedScale(
        scale: selected ? 0.97 : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: selected
                  ? context.secondary
                  : context.onTertiary.withValues(alpha: 0.10),
              width: selected ? 2.5 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: context.secondary.withValues(alpha: 0.22),
                      blurRadius: 14,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: Material(
              color: context.surface,
              child: InkWell(
                onTap: onSelected,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    EventImage(
                      source: image.location,
                      error: _ImageError(color: context.onTertiary),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      color: selected
                          ? context.secondary.withValues(alpha: 0.08)
                          : Colors.transparent,
                    ),
                    if (selected)
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.secondary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.24),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.check_rounded,
                              size: 15,
                              color: context.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Tooltip(
                        message: context.l10n.eventEditorExpandImage,
                        child: Material(
                          color: Colors.black.withValues(alpha: 0.58),
                          shape: const CircleBorder(),
                          child: InkResponse(
                            key: ValueKey('event-image-expand-$index'),
                            onTap: onExpand,
                            radius: 22,
                            child: const SizedBox.square(
                              dimension: 34,
                              child: Icon(
                                Icons.open_in_full_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool?> showEventImageViewer({
  required BuildContext context,
  required InstitutionResource image,
  required bool selected,
}) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withValues(alpha: 0.88),
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (context, _, __) {
      return _EventImageViewer(
        source: image.location,
        selected: selected,
      );
    },
    transitionBuilder: (context, animation, _, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: 0.96, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _EventImageViewer extends StatelessWidget {
  final String source;
  final bool selected;

  const _EventImageViewer({
    required this.source,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.responsive.pageHorizontalPadding;

    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                minScale: 0.8,
                maxScale: 4,
                child: Center(
                  child: EventImage(
                    source: source,
                    fit: BoxFit.contain,
                    error: const _ImageError(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                onPressed: () => Navigator.of(context).pop(),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.12),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.close_rounded),
              ),
            ),
            Positioned(
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: 18,
              child: AppActionButton(
                text: selected
                    ? context.l10n.eventEditorImageSelected
                    : context.l10n.eventEditorChooseImage,
                icon: selected
                    ? Icons.check_rounded
                    : Icons.add_photo_alternate_outlined,
                color: context.secondary,
                foregroundColor: context.onSecondary,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageError extends StatelessWidget {
  final Color color;

  const _ImageError({required this.color});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color.withValues(alpha: 0.06),
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: color.withValues(alpha: 0.38),
        ),
      ),
    );
  }
}
