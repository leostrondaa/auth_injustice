import 'package:autth_injustice_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class CloudBackground extends StatelessWidget {
  const CloudBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // BREAKPOINT: Define se a tela é pequena verticalmente (ex: < 650px)
    final isShortScreen = screenHeight < 650;

    final cloudDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
    );

    // Configurações dinâmicas do Logo baseadas na altura da tela
    final logoWidth = isShortScreen ? screenWidth * 0.4 : screenWidth * 0.6;
    // Se a tela for pequena, "empurramos" o logo mais para baixo para esconder a rotação
    final logoBottomOffset = isShortScreen ? -80.0 : -60.0;

    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // =========================================
          // IF logo
          // =========================================
          Positioned(
            bottom: logoBottomOffset,
            right: 15,
            child: Transform.rotate(
              angle: 0.55,
              child: Opacity(
                opacity: 1,
                child: Image.asset(
                  AppAssets.ifLogoWhite,
                  width: logoWidth,
                  fit: BoxFit.contain,
                  cacheWidth: (logoWidth * mediaQuery.devicePixelRatio).round(),
                ),
              ),
            ),
          ),

          // =========================================
          // NUVENS
          // =========================================

          // Nuvem da Esquerda (Parte Superior)
          Positioned(
            top: screenHeight * 0.35,
            left: -60,
            child: Container(
              width: isShortScreen ? 90 : 120,
              height: isShortScreen ? 80 : 110,
              decoration: cloudDecoration,
            ),
          ),

          // Nuvem da Esquerda (Parte Inferior Emendada)
          Positioned(
            top: screenHeight * 0.41,
            left: -50,
            child: Container(
              width: isShortScreen ? 150 : 200,
              height: isShortScreen ? 90 : 120,
              decoration: cloudDecoration,
            ),
          ),

          // Nuvem da Direita (Parte Superior)
          Positioned(
            top: screenHeight * 0.44,
            right: -150,
            child: Container(
              width: isShortScreen ? 180 : 220,
              height: isShortScreen ? 110 : 140,
              decoration: cloudDecoration,
            ),
          ),

          // Nuvem da Direita (Parte Inferior Emendada)
          Positioned(
            top: screenHeight * 0.54,
            right: -60,
            child: Container(
              width: isShortScreen ? 180 : 220,
              height: isShortScreen ? 120 : 150,
              decoration: cloudDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
