import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ComplementaryHoursStatus extends StatelessWidget {
  final bool isLoading;
  final String? message;
  final VoidCallback? onRetry;

  const ComplementaryHoursStatus.loading({super.key})
      : isLoading = true,
        message = null,
        onRetry = null;

  const ComplementaryHoursStatus.error({
    super.key,
    required this.message,
    required this.onRetry,
  }) : isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: context.secondary),
      );
    }

    return Center(
      child: Padding(
        padding: context.extraPagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.hourglass_disabled_rounded,
              size: 36,
              color: context.onTertiary.withValues(alpha: 0.62),
            ),
            const SizedBox(height: 12),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(color: context.onTertiary),
            ),
            const SizedBox(height: 16),
            IconButton.filledTonal(
              onPressed: onRetry,
              tooltip: context.l10n.commonRetry,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
