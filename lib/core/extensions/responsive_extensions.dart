import 'package:flutter/material.dart';

export 'package:autth_injustice_app/core/responsive/app_responsive.dart';

import 'package:autth_injustice_app/core/responsive/app_responsive.dart';

extension ResponsiveContext on BuildContext {
  Size get screenSize => responsive.size;

  bool get isMediumScreen =>
      screenSize.height >= 750 && screenSize.height < 900;
  bool get isLargeScreen => screenSize.height >= 900;

  bool get isPhone => responsive.isPhone;
  bool get isTablet => responsive.isTablet;
  bool get isDesktop => responsive.isExpanded;

  bool get isVerySmallScreen => screenSize.height < 700;
  bool get isSmallScreen => screenSize.height < 850;

  double get authSheetTopRatio {
    if (isVerySmallScreen) return 0.20;
    if (isSmallScreen) return 0.28;
    return 0.38;
  }

  double get formTopSpacing =>
      isVerySmallScreen ? 16.0 : (isSmallScreen ? 24.0 : 40.0);
  double get formBottomSpacing =>
      isVerySmallScreen ? 20.0 : (isSmallScreen ? 32.0 : 48.0);

  double get maxFormWidth => 500.0;

  double get headerTopSpacing => isSmallScreen ? 20.0 : 50.0;
}
