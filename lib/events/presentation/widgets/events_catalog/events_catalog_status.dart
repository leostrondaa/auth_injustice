import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EventsCatalogStatus extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final bool isLoading;

  const EventsCatalogStatus.loading({super.key})
      : message = null,
        onRetry = null,
        isLoading = true;

  const EventsCatalogStatus.error({
    super.key,
    required String this.message,
    required VoidCallback this.onRetry,
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
              Icons.event_busy_outlined,
              size: 34,
              color: context.onTertiary.withValues(alpha: 0.72),
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
              tooltip: 'Tentar novamente',
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
