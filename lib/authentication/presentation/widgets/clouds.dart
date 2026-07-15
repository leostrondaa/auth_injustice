import 'package:autth_injustice_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class CloudBackground extends StatelessWidget {
  const CloudBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final cloudDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
    );

    return RepaintBoundary(
      child: Stack(
        children: [
          // IF logo (Parte Inferior)
          Positioned(
            top: screenHeight - 260,
            right: 15,
            child: Transform.rotate(
              angle: 0.55,
              child: Image.asset(
                AppAssets.ifLogoWhite,
                width: screenWidth * 0.6,
                fit: BoxFit.contain,
                cacheWidth:
                    (screenWidth * 0.6 * mediaQuery.devicePixelRatio).round(),
              ),
            ),
          ),

          // Nuvem da Esquerda (Parte Superior)
          Positioned(
            top: screenHeight * 0.35,
            left: -60,
            child: Container(
              width: 120,
              height: 110,
              decoration: cloudDecoration,
            ),
          ),

          // Nuvem da Esquerda (Parte Inferior Emendada)
          Positioned(
            top: screenHeight * 0.41,
            left: -50,
            child: Container(
              width: 200,
              height: 120,
              decoration: cloudDecoration,
            ),
          ),

          // Nuvem da Direita (Parte Superior)
          Positioned(
            top: screenHeight * 0.44,
            right: -150,
            child: Container(
              width: 220,
              height: 140,
              decoration: cloudDecoration,
            ),
          ),

          // Nuvem da Direita (Parte Inferior Emendada)
          Positioned(
            top: screenHeight * 0.54,
            right: -60,
            child: Container(
              width: 220,
              height: 150,
              decoration: cloudDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
