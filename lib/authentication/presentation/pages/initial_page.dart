import 'dart:async';
import 'package:autth_injustice_app/authentication/presentation/widgets/button_primary.dart';
import 'package:autth_injustice_app/core/di/dependency_injection.dart';
import 'package:autth_injustice_app/core/routes/app_routes.dart';
import 'package:autth_injustice_app/core/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/auth_session_viewmodel.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Pegamos a largura da tela para fazer as formas do fundo responsivas
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Stack(
        children: [
          // Nuvem da Esquerda
          Positioned(
            top: 200,
            left: -60,
            child: Container(
              width: 140,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: -50,
            child: Container(
              width: 230,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          // Nuvem da Direita (Um pouco mais abaixo)
          Positioned(
            top: 270,
            right: -170,
            child: Container(
              width: 230,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          ),
          Positioned(
            top: 330,
            right: -60,
            child: Container(
              width: 230,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Welcome To\nWhere IF',
                    textAlign: TextAlign.start,
                    style: context.text.headlineLarge?.copyWith(
                      color: context.colors.onPrimary,
                    ),
                  ),
                  const Spacer(),
                  ButtonPrimary(
                    text: 'Continuar',
                    onTap: () {},
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
