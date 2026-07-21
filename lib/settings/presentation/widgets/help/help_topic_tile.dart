import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HelpTopicTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String explanation;
  final double scale;
  final double textScale;

  const HelpTopicTile({
    super.key,
    required this.icon,
    required this.title,
    required this.explanation,
    required this.scale,
    required this.textScale,
  });

  @override
  State<HelpTopicTile> createState() => _HelpTopicTileState();
}

class _HelpTopicTileState extends State<HelpTopicTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      expanded: _expanded,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(14 * widget.scale),
          splashColor: context.secondary.withValues(alpha: 0.08),
          highlightColor: context.secondary.withValues(alpha: 0.035),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4 * widget.scale,
              vertical: 10 * widget.scale,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42 * widget.scale,
                      height: 42 * widget.scale,
                      decoration: BoxDecoration(
                        color: context.secondary.withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(12 * widget.scale),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 22 * widget.scale,
                        color: context.secondary,
                      ),
                    ),
                    SizedBox(width: 13 * widget.scale),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: context.bodyMedium?.copyWith(
                          color: context.onTertiary,
                          fontSize: 13.5 * widget.textScale,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8 * widget.scale),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24 * widget.scale,
                        color: context.onTertiary.withValues(alpha: 0.62),
                      ),
                    ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.topCenter,
                  child: _expanded
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: 55 * widget.scale,
                            top: 10 * widget.scale,
                            right: 8 * widget.scale,
                            bottom: 4 * widget.scale,
                          ),
                          child: Text(
                            widget.explanation,
                            style: context.bodySmall?.copyWith(
                              color: context.onTertiary.withValues(alpha: 0.64),
                              fontSize: 11.5 * widget.textScale,
                              height: 1.45,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
