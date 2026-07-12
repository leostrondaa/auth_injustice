import 'package:flutter/material.dart';

class CloudBackground extends StatelessWidget {
  const CloudBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    final screenSize = view.physicalSize / view.devicePixelRatio;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final cloudDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
    );

    return Stack(
      children: [
        // IF logo (Parte Inferior)
        Positioned(
          top: screenHeight - 260,
          right: 15,
          child: Transform.rotate(
            angle: 0.55,
            child: Image.asset(
              'images/if_logo.png',
              width: screenWidth * 0.6,
              fit: BoxFit.contain,
            ),
          ),
        ),

        // Nuvem da Esquerda (Parte Superior)
        Positioned(
          top: 290,
          left: -60,
          child: Container(
            width: 120,
            height: 110,
            decoration: cloudDecoration,
          ),
        ),

        // Nuvem da Esquerda (Parte Inferior Emendada)
        Positioned(
          top: 340,
          left: -50,
          child: Container(
            width: 200,
            height: 120,
            decoration: cloudDecoration,
          ),
        ),

        // Nuvem da Direita (Parte Superior)
        Positioned(
          top: 370,
          right: -150,
          child: Container(
            width: 220,
            height: 140,
            decoration: cloudDecoration,
          ),
        ),

        // Nuvem da Direita (Parte Inferior Emendada)
        Positioned(
          top: 450,
          right: -60,
          child: Container(
            width: 220,
            height: 150,
            decoration: cloudDecoration,
          ),
        ),
      ],
    );
  }
}
