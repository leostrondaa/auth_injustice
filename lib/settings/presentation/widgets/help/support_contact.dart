import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SupportContact extends StatelessWidget {
  final String email;
  final double scale;
  final double textScale;
  final VoidCallback onCopyEmail;

  const SupportContact({
    super.key,
    required this.email,
    required this.scale,
    required this.textScale,
    required this.onCopyEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46 * scale,
              height: 46 * scale,
              decoration: BoxDecoration(
                color: context.secondary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(13 * scale),
              ),
              child: Icon(
                Icons.support_agent_rounded,
                size: 25 * scale,
                color: context.secondary,
              ),
            ),
            SizedBox(width: 14 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.helpContactTitle,
                    style: context.titleLarge?.copyWith(
                      color: context.onTertiary,
                      fontSize: 17 * textScale,
                    ),
                  ),
                  SizedBox(height: 6 * scale),
                  Text(
                    context.l10n.helpContactDescription,
                    style: context.bodySmall?.copyWith(
                      color: context.onTertiary.withValues(alpha: 0.62),
                      fontSize: 11.5 * textScale,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18 * scale),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onCopyEmail,
            borderRadius: BorderRadius.circular(14 * scale),
            splashColor: context.secondary.withValues(alpha: 0.08),
            child: Container(
              constraints: BoxConstraints(minHeight: 54 * scale),
              padding: EdgeInsets.symmetric(
                horizontal: 14 * scale,
                vertical: 10 * scale,
              ),
              decoration: BoxDecoration(
                color: context.secondary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14 * scale),
                border: Border.all(
                  color: context.secondary.withValues(alpha: 0.20),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.mail_outline_rounded,
                    color: context.secondary,
                    size: 22 * scale,
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium?.copyWith(
                        color: context.onTertiary,
                        fontSize: 13 * textScale,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: context.l10n.helpCopyEmail,
                    child: Icon(
                      Icons.content_copy_rounded,
                      color: context.onTertiary.withValues(alpha: 0.62),
                      size: 19 * scale,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
