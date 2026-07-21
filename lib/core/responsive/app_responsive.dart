import 'dart:math' as math;

import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum AppWidthClass {
  micro,
  tiny,
  narrow,
  compact,
  standard,
  largePhone,
  tablet,
  expanded,
}

enum AppHeightClass {
  veryShort,
  short,
  compact,
  regular,
  tall,
  veryTall,
}

@immutable
class AppResponsive {
  final Size size;
  final EdgeInsets viewPadding;
  final double devicePixelRatio;
  final AppWidthClass widthClass;
  final AppHeightClass heightClass;

  const AppResponsive._({
    required this.size,
    required this.viewPadding,
    required this.devicePixelRatio,
    required this.widthClass,
    required this.heightClass,
  });

  factory AppResponsive.fromContext(BuildContext context) {
    final media = MediaQuery.of(context);

    return AppResponsive._(
      size: media.size,
      viewPadding: media.viewPadding,
      devicePixelRatio: media.devicePixelRatio,
      widthClass: _widthClassFor(media.size.width),
      heightClass: _heightClassFor(media.size.height),
    );
  }

  double get width => size.width;
  double get height => size.height;
  double get shortestSide => size.shortestSide;
  double get aspectRatio => size.aspectRatio;

  bool get isMicro => widthClass == AppWidthClass.micro;
  bool get isTiny => widthClass == AppWidthClass.tiny;
  bool get isVeryCompact => widthClass.index <= AppWidthClass.tiny.index;
  bool get isCompact => widthClass.index <= AppWidthClass.standard.index;
  bool get isPhone => widthClass.index <= AppWidthClass.largePhone.index;
  bool get isTablet => widthClass == AppWidthClass.tablet;
  bool get isExpanded => widthClass == AppWidthClass.expanded;
  bool get isShort => heightClass.index <= AppHeightClass.short.index;
  bool get isTall => heightClass.index >= AppHeightClass.tall.index;

  double get widthScale => switch (widthClass) {
        AppWidthClass.micro => 0.72,
        AppWidthClass.tiny => 0.80,
        AppWidthClass.narrow => 0.88,
        AppWidthClass.compact => 0.94,
        AppWidthClass.standard => 0.98,
        AppWidthClass.largePhone => 1.0,
        AppWidthClass.tablet => 1.04,
        AppWidthClass.expanded => 1.08,
      };

  double get heightScale => switch (heightClass) {
        AppHeightClass.veryShort => 0.78,
        AppHeightClass.short => 0.86,
        AppHeightClass.compact => 0.94,
        AppHeightClass.regular => 1.0,
        AppHeightClass.tall => 1.04,
        AppHeightClass.veryTall => 1.08,
      };

  double get layoutScale => math.min(widthScale, heightScale);

  double get textScale => switch (widthClass) {
        AppWidthClass.micro => 0.84,
        AppWidthClass.tiny => 0.88,
        AppWidthClass.narrow => 0.92,
        AppWidthClass.compact => 0.96,
        AppWidthClass.standard => 0.98,
        AppWidthClass.largePhone => 1.0,
        AppWidthClass.tablet => 1.03,
        AppWidthClass.expanded => 1.06,
      };

  double get iconScale => switch (widthClass) {
        AppWidthClass.micro => 0.82,
        AppWidthClass.tiny => 0.88,
        AppWidthClass.narrow => 0.92,
        AppWidthClass.compact => 0.96,
        AppWidthClass.standard => 0.98,
        AppWidthClass.largePhone => 1.0,
        AppWidthClass.tablet => 1.04,
        AppWidthClass.expanded => 1.08,
      };

  double get spacingScale => layoutScale;

  double get pageHorizontalPadding => switch (widthClass) {
        AppWidthClass.micro ||
        AppWidthClass.tiny ||
        AppWidthClass.narrow =>
          AppDesign.pageHorizontalPadding,
        AppWidthClass.compact => 24.0,
        AppWidthClass.standard ||
        AppWidthClass.largePhone =>
          AppDesign.extraPageHorizontalPadding,
        AppWidthClass.tablet => 32.0,
        AppWidthClass.expanded => 40.0,
      };

  double get contentMaxWidth => switch (widthClass) {
        AppWidthClass.micro ||
        AppWidthClass.tiny ||
        AppWidthClass.narrow ||
        AppWidthClass.compact ||
        AppWidthClass.standard =>
          width,
        AppWidthClass.largePhone => math.min(width, 560.0),
        AppWidthClass.tablet => 640.0,
        AppWidthClass.expanded => 720.0,
      };

  double scaled(
    double value, {
    double? min,
    double? max,
  }) {
    final result = value * layoutScale;
    if (min == null && max == null) return result;

    return result.clamp(min ?? double.negativeInfinity, max ?? double.infinity);
  }

  static AppWidthClass _widthClassFor(double width) {
    if (width < 300) return AppWidthClass.micro;
    if (width < 340) return AppWidthClass.tiny;
    if (width < 370) return AppWidthClass.narrow;
    if (width < 400) return AppWidthClass.compact;
    if (width < 430) return AppWidthClass.standard;
    if (width < 600) return AppWidthClass.largePhone;
    if (width < 840) return AppWidthClass.tablet;
    return AppWidthClass.expanded;
  }

  static AppHeightClass _heightClassFor(double height) {
    if (height < 600) return AppHeightClass.veryShort;
    if (height < 700) return AppHeightClass.short;
    if (height < 800) return AppHeightClass.compact;
    if (height < 950) return AppHeightClass.regular;
    if (height < 1100) return AppHeightClass.tall;
    return AppHeightClass.veryTall;
  }
}

extension AppResponsiveContext on BuildContext {
  AppResponsive get responsive => AppResponsive.fromContext(this);
}
