import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EventsSectionTitle extends StatelessWidget {
  final String title;

  const EventsSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.headlineMedium?.copyWith(
        color: context.onTertiary,
      ),
    );
  }
}
