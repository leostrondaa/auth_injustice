import 'package:autth_injustice_app/core/constants/app_assets.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AboutIdentity extends StatelessWidget {
  final double scale;
  final double textScale;

  const AboutIdentity({
    super.key,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96 * scale,
          height: 96 * scale,
          padding: EdgeInsets.all(15 * scale),
          decoration: BoxDecoration(
            color: context.onTertiary,
            borderRadius: BorderRadius.circular(18 * scale),
            boxShadow: [
              BoxShadow(
                color: context.secondary.withValues(alpha: 0.22),
                blurRadius: 24 * scale,
                offset: Offset(0, 8 * scale),
              ),
            ],
          ),
          child: Image.asset(
            context.isDarkMode ? AppAssets.ifLogoBlack : AppAssets.ifLogoWhite,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Image.asset(
              AppAssets.ifLogoBlack,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 18 * scale),
        Text(
          'WhereIF',
          textAlign: TextAlign.center,
          style: context.displaySmall?.copyWith(
            color: context.onTertiary,
            fontSize: 31 * textScale,
          ),
        ),
        SizedBox(height: 8 * scale),
        Text(
          context.l10n.aboutDescription,
          textAlign: TextAlign.center,
          style: context.bodyMedium?.copyWith(
            color: context.onTertiary.withValues(alpha: 0.70),
            fontSize: 13 * textScale,
          ),
        ),
        SizedBox(height: 14 * scale),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12 * scale,
            vertical: 7 * scale,
          ),
          decoration: BoxDecoration(
            color: context.secondary.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(
              color: context.secondary.withValues(alpha: 0.34),
            ),
          ),
          child: Text(
            '${context.l10n.aboutVersion} 1.0.0',
            style: context.text.labelMedium?.copyWith(
              color: context.onTertiary,
              fontSize: 11 * textScale,
            ),
          ),
        ),
        SizedBox(height: 22 * scale),
        Divider(color: context.onTertiary.withValues(alpha: 0.10), height: 1),
        SizedBox(height: 20 * scale),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42 * scale,
              height: 42 * scale,
              decoration: BoxDecoration(
                color: context.secondary.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Icon(
                Icons.school_outlined,
                color: context.secondary,
                size: 23 * scale,
              ),
            ),
            SizedBox(width: 14 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.aboutAcademicProject,
                    style: context.bodyMedium?.copyWith(
                      color: context.onTertiary,
                      fontSize: 13 * textScale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5 * scale),
                  Text(
                    context.l10n.aboutInstitution,
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
      ],
    );
  }
}
