import 'package:autth_injustice_app/authentication/presentation/widgets/button_primary.dart';
import 'package:autth_injustice_app/authentication/presentation/widgets/text_button.dart';
import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AuthFeedbackPage extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;

  final String? primaryButtonText;
  final VoidCallback? onPrimaryTap;
  final String? footerBaseText;
  final String? footerActionText;
  final VoidCallback? onFooterTap;

  const AuthFeedbackPage({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.primaryButtonText,
    this.onPrimaryTap,
    this.footerBaseText,
    this.footerActionText,
    this.onFooterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.tertiary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            // Mantém a estética perfeita em telas largas (tablets/web)
            constraints: BoxConstraints(maxWidth: context.maxFormWidth),
            child: Padding(
              padding: context.extraPagePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),

                  // ÍCONE CENTRAL
                  Center(child: icon),

                  const SizedBox(height: 40),

                  // TÍTULO
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.text.headlineMedium?.copyWith(
                      color: context.colors.onSurface,
                      fontWeight: FontWeight.bold,
                      // Ajuste responsivo para telas minúsculas
                      fontSize: context.isVerySmallScreen ? 24 : 28,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // SUBTÍTULO
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: context.text.bodyLarge?.copyWith(
                      color: const Color(0xFF757575), // Cor neutra acinzentada
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // BOTÃO PRIMÁRIO (Se existir)
                  if (primaryButtonText != null && onPrimaryTap != null)
                    ButtonPrimary(
                      text: primaryButtonText!,
                      onTap: onPrimaryTap!,
                    ),

                  const Spacer(),

                  // RODAPÉ COM TEXTO CLICÁVEL (Se existir)
                  if (footerBaseText != null &&
                      footerActionText != null &&
                      onFooterTap != null)
                    Center(
                      child: TextButtonRich(
                        baseText: footerBaseText!,
                        actionText: footerActionText!,
                        onTap: onFooterTap!,
                        actionColor: context.colors.primary, // Cor de destaque
                      ),
                    ),

                  SizedBox(height: context.isVerySmallScreen ? 16 : 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
