import 'package:flutter/widgets.dart' show BorderRadius;

abstract final class AppShapes {
  static const double radiusSm = 4;
  static const double radiusDefault = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 9999;

  static const double radiusInput = radiusMd;
  static const double radiusCard = 32;
  static const double radiusButton = 20;
  static const double radiusIconContainer = 32;

  static BorderRadius get inputRadius => BorderRadius.circular(radiusInput);
  static BorderRadius get cardRadius => BorderRadius.circular(radiusCard);
  static BorderRadius get buttonRadius => BorderRadius.circular(radiusButton);
}
