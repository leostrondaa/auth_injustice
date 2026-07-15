import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final IconData icon;

  const BackButtonWidget({
    super.key,
    this.onTap,
    this.color,
    this.icon = Icons.arrow_back,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        Icons.arrow_back,
        color: color ?? context.colors.onTertiary,
      ),
      onPressed: onTap ?? () => context.pop(),
    );
  }
}
