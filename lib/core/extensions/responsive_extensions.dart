import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  bool get isMediumScreen => screenSize.height >= 750 && screenSize.height < 900;
  bool get isLargeScreen => screenSize.height >= 900;

  bool get isPhone => screenSize.width < 600;
  bool get isTablet => screenSize.width >= 600 && screenSize.width < 1024;
  bool get isDesktop => screenSize.width >= 1024;

  bool get isVerySmallScreen => screenSize.height < 700; // Antes era 600
  bool get isSmallScreen => screenSize.height < 850;     // Antes era 750

  double get authSheetTopRatio {
    if (isVerySmallScreen) return 0.20; // Agora o seu celular deve cair aqui!
    if (isSmallScreen) return 0.28;     
    return 0.38;                        
  }

  // Reduza também os espaçamentos internos para garantir que o botão suba:
  double get formTopSpacing => isVerySmallScreen ? 16.0 : (isSmallScreen ? 24.0 : 40.0);
  double get formBottomSpacing => isVerySmallScreen ? 20.0 : (isSmallScreen ? 32.0 : 48.0);

  // Largura máxima padrão para formulários centrais (impedir que estique no tablet/web)
  double get maxFormWidth => 500.0;

  // Espaçamentos verticais padronizados e adaptáveis
  double get headerTopSpacing => isSmallScreen ? 20.0 : 50.0;
}