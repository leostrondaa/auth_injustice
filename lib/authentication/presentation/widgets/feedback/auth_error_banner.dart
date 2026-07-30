import 'package:autth_injustice_app/core/extensions/app_localizations.dart';
import 'package:autth_injustice_app/core/widgets/feedback/animated_error_message.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthErrorBanner extends StatelessWidget {
  final ReadonlySignal<String?> error;

  const AuthErrorBanner({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final message = error.value;

      return AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutBack,
        child: message == null
            ? const SizedBox.shrink()
            : AnimatedErrorMessage(
                message: context.translateErrorKey(message),
              ),
      );
    });
  }
}
