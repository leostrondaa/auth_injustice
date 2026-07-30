import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/loading_dots.dart';
import 'package:flutter/material.dart';

class AppStatusView extends StatelessWidget {
  final bool isLoading;
  final IconData? icon;
  final String? title;
  final String? message;
  final Color? color;
  final String? actionLabel;
  final IconData actionIcon;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry? padding;
  final bool compact;

  const AppStatusView({
    super.key,
    this.icon,
    this.title,
    this.message,
    this.color,
    this.actionLabel,
    this.actionIcon = Icons.refresh_rounded,
    this.onAction,
    this.padding,
    this.compact = false,
  })  : isLoading = false,
        assert(
          (actionLabel == null) == (onAction == null),
          'actionLabel and onAction must be provided together.',
        ),
        assert(
          icon != null || title != null || message != null,
          'Provide at least an icon, title, or message.',
        );

  const AppStatusView.loading({
    super.key,
    this.color,
    this.padding,
    this.compact = false,
  })  : isLoading = true,
        icon = null,
        title = null,
        message = null,
        actionLabel = null,
        actionIcon = Icons.refresh_rounded,
        onAction = null;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final scale = responsive.layoutScale;
    final textScale = responsive.textScale;
    final accent = color ?? context.secondary;
    final iconSize = (compact ? 24.0 : 42.0) * scale;
    final iconGap = (compact ? 6.0 : 14.0) * scale;
    final titleSize = (compact ? 13.0 : 17.0) * textScale;
    final messageSize = (compact ? 10.0 : 11.5) * textScale;

    if (isLoading) {
      return Center(
        child: LoadingDots(
          color: accent,
          size: 7 * scale,
          spacing: 3 * scale,
          rise: 5 * scale,
        ),
      );
    }

    return Semantics(
      liveRegion: true,
      label: [title, message].whereType<String>().join('. '),
      child: Center(
        child: Padding(
          padding: padding ?? context.extraPagePadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 360 * scale),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: iconSize,
                    color: color?.withValues(alpha: 0.82) ??
                        context.onTertiary.withValues(alpha: 0.36),
                  ),
                  SizedBox(height: iconGap),
                ],
                if (title != null)
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: context.titleLarge?.copyWith(
                      color: context.onTertiary,
                      fontSize: titleSize,
                      height: 1.18,
                    ),
                  ),
                if (message != null) ...[
                  SizedBox(height: (compact ? 3 : 6) * scale),
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: context.bodySmall?.copyWith(
                      color: context.onTertiary.withValues(alpha: 0.58),
                      fontSize: messageSize,
                      height: 1.35,
                    ),
                  ),
                ],
                if (onAction != null) ...[
                  SizedBox(height: (compact ? 4 : 14) * scale),
                  TextButton.icon(
                    onPressed: onAction,
                    icon: Icon(actionIcon, size: 18 * scale),
                    label: Text(actionLabel!),
                    style: TextButton.styleFrom(
                      foregroundColor: accent,
                      minimumSize: compact ? Size(0, 36 * scale) : null,
                      padding: compact
                          ? EdgeInsets.symmetric(horizontal: 10 * scale)
                          : null,
                      tapTargetSize:
                          compact ? MaterialTapTargetSize.shrinkWrap : null,
                      visualDensity: compact ? VisualDensity.compact : null,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
