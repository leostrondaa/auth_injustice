import 'dart:async';

import 'package:autth_injustice_app/core/constants/app_assets.dart'; // ✅ Importe seu arquivo de assets
import 'package:autth_injustice_app/core/di/dependency_injection.dart';

import 'package:autth_injustice_app/core/routes/app_routes.dart';
import 'package:autth_injustice_app/core/routes/auth_routes.dart';
import 'package:autth_injustice_app/core/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../controllers/auth/auth_session_viewmodel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    hideKeyboard();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.28, end: 0.3).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animController.forward();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final authSession = injector.get<AuthSessionViewModel>();

    await Future.wait([
      Future.delayed(const Duration(milliseconds: 800)),
      // authSession.loadCurrentUser(),
    ]);

    if (!mounted) return;
    _animController.duration = const Duration(milliseconds: 200);
    await _animController.reverse();

    if (!mounted) return;

    final loggedIn = authSession.session.isAuthenticated;

    if (loggedIn) {
      context.goNamed(GlobalRouteNames.underConstruction);
    } else {
      context.goNamed(AuthRouteNames.initial);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.tertiary;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: RepaintBoundary(
          child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                context.isDarkMode
                    ? AppAssets.ifLogoWhite
                    : AppAssets.ifLogoBlack,
                width: screenWidth * 0.55,
                fit: BoxFit.contain,
                cacheWidth: (screenWidth * 0.55 * devicePixelRatio).round(),
              )),
        ),
      ),
    );
  }
}
