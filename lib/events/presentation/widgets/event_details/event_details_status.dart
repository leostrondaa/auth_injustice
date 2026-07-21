import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EventDetailsStatus extends StatelessWidget {
  final String? message;
  final VoidCallback? onBack;
  final VoidCallback? onRetry;
  final bool isLoading;

  const EventDetailsStatus.loading({super.key})
      : message = null,
        onBack = null,
        onRetry = null,
        isLoading = true;

  const EventDetailsStatus.error({
    super.key,
    required this.message,
    required this.onBack,
    required this.onRetry,
  }) : isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: context.secondary),
      );
    }

    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            left: context.extraPagePadding.left,
            top: 8,
            child: IconButton(
              onPressed: onBack,
              tooltip: 'Voltar',
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          Center(
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
                    style: context.bodyMedium?.copyWith(
                      color: context.onTertiary,
                    ),
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
          ),
        ],
      ),
    );
  }
}
