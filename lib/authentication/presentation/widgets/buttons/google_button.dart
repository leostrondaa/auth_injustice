import 'package:autth_injustice_app/core/constants/app_assets.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignInButton extends StatefulWidget {
  final VoidCallback onTap;

  const GoogleSignInButton({
    super.key,
    required this.onTap,
  });

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () async {
        setState(() => _isPressed = true);
        await Future.delayed(const Duration(milliseconds: 120));
        if (mounted) {
          setState(() => _isPressed = false);
          widget.onTap();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFF5EBE6),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 80),
              opacity: _isPressed ? 0.4 : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppAssets.googleIcon,
                    width: 24,
                    height: 24,
                  ),
                  Text(
                    context.l10n.googleButton,
                    style: TextStyle(
                      color: Color(0xFF616161),
                      fontSize: context.text.bodyMedium?.fontSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF9E9E9E),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
