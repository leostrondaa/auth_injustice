import 'package:autth_injustice_app/core/widgets/feedback/animated_error_message.dart';
import 'package:flutter/material.dart';

class AppEditorErrorBanner extends StatelessWidget {
  final String? message;

  const AppEditorErrorBanner({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutBack,
      child: message == null
          ? const SizedBox.shrink()
          : AnimatedErrorMessage(message: message),
    );
  }
}
