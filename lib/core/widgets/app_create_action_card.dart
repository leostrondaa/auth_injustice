import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppCreateActionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final double scale;
  final double textScale;
  final IconData icon;

  const AppCreateActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.scale,
    required this.textScale,
    this.icon = Icons.add_rounded,
  });

  @override
  State<AppCreateActionCard> createState() => _AppCreateActionCardState();
}

class _AppCreateActionCardState extends State<AppCreateActionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18 * widget.scale);
    final accent = context.secondary;

    return AnimatedScale(
      scale: _pressed ? 0.982 : 1,
      duration: Duration(milliseconds: _pressed ? 90 : 210),
      curve: Curves.easeOutCubic,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: accent.withValues(
                alpha: context.isDarkMode ? 0.16 : 0.10,
              ),
              blurRadius: 22 * widget.scale,
              offset: Offset(0, 9 * widget.scale),
            ),
          ],
        ),
        child: Material(
          color: context.isDarkMode
              ? context.surface
              : context.tertiary.withValues(alpha: 1),
          borderRadius: radius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            onHighlightChanged: (value) {
              if (_pressed == value) return;
              setState(() => _pressed = value);
            },
            splashColor: accent.withValues(alpha: 0.12),
            child: Ink(
              height: 70 * widget.scale,
              padding: EdgeInsets.symmetric(horizontal: 14 * widget.scale),
              decoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(
                  color: context.primary.withValues(
                    alpha: context.isDarkMode ? 0.28 : 0.18,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44 * widget.scale,
                    height: 44 * widget.scale,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          context.primary.withValues(alpha: 0.8),
                          context.colors.error.withValues(alpha: 0.5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14 * widget.scale),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.4),
                          blurRadius: 14 * widget.scale,
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      size: 27 * widget.scale,
                      color: context.onSecondary,
                    ),
                  ),
                  SizedBox(width: 13 * widget.scale),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.titleLarge?.copyWith(
                            color: context.onTertiary,
                            fontSize: 15 * widget.textScale,
                          ),
                        ),
                        SizedBox(height: 2 * widget.scale),
                        Text(
                          widget.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodySmall?.copyWith(
                            color: context.onTertiary.withValues(alpha: 0.48),
                            fontSize: 10.5 * widget.textScale,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 20 * widget.scale,
                    color: context.onTertiary.withValues(alpha: 0.42),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
