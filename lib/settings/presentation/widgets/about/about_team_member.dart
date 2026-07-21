import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AboutTeamMember extends StatelessWidget {
  final String name;
  final String role;
  final double scale;
  final double textScale;
  final String? imagePath;

  const AboutTeamMember({
    super.key,
    required this.name,
    required this.role,
    required this.scale,
    required this.textScale,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 72 * scale,
            height: 72 * scale,
            padding: EdgeInsets.all(3 * scale),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.secondary.withValues(alpha: 0.55),
                width: 1.5,
              ),
            ),
            child: ClipOval(
              child: imagePath == null
                  ? ColoredBox(
                      color: context.secondary.withValues(alpha: 0.16),
                      child: Center(
                        child: Text(
                          name.characters.first.toUpperCase(),
                          style: context.headlineMedium?.copyWith(
                            color: context.tertiary,
                            fontSize: 24 * textScale,
                          ),
                        ),
                      ),
                    )
                  : Image.asset(
                      imagePath!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(height: 10 * scale),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: context.bodyMedium?.copyWith(
              color: context.onTertiary,
              fontSize: 13 * textScale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 3 * scale),
          Text(
            role,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: context.bodySmall?.copyWith(
              color: context.onTertiary.withValues(alpha: 0.55),
              fontSize: 10.5 * textScale,
            ),
          ),
        ],
      ),
    );
  }
}
