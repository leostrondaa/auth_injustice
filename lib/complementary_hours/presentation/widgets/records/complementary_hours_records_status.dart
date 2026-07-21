import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/loading_dots.dart';
import 'package:flutter/material.dart';

class ComplementaryHoursRecordsStatus extends StatelessWidget {
  final bool loading;
  final String? errorMessage;
  final double scale;
  final VoidCallback onRetry;

  const ComplementaryHoursRecordsStatus({
    super.key,
    required this.loading,
    required this.errorMessage,
    required this.scale,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: LoadingDots(
          color: context.secondary,
          size: 7 * scale,
          spacing: 3 * scale,
          rise: 5 * scale,
        ),
      );
    }

    final hasError = errorMessage != null;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28 * scale),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasError ? Icons.cloud_off_rounded : Icons.event_note_outlined,
              size: 44 * scale,
              color: context.onTertiary.withValues(alpha: 0.34),
            ),
            SizedBox(height: 16 * scale),
            Text(
              hasError
                  ? context.l10n.complementaryHoursRecordsLoadError
                  : context.l10n.complementaryHoursRecordsEmpty,
              textAlign: TextAlign.center,
              style: context.titleLarge?.copyWith(
                color: context.onTertiary,
                fontSize: 18 * scale,
              ),
            ),
            if (hasError) ...[
              SizedBox(height: 16 * scale),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(context.l10n.commonRetry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
