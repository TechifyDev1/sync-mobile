import 'package:flutter/cupertino.dart';

abstract final class AppColors {
  static const Color primary = CupertinoColors.black;
  static const Color primaryContainer = CupertinoColors.black;
  static const Color onPrimary = CupertinoColors.white;

  // 1. New elegant, premium off-white/cool-grey background
  static const Color background =
      CupertinoColors.systemGroupedBackground; // Or Color(0xFFF2F2F7)

  // 2. Lower the opacity back down now that the background isn't pure white
  static final Color glassSurface = CupertinoColors.white.withValues(
    alpha: 0.4,
  );

  // 3. Define top-light and bottom-dark colors for the border gradient
  static final Color strokeLight = CupertinoColors.white.withValues(alpha: 0.6);
  static final Color strokeDark = CupertinoColors.systemGrey3.withValues(
    alpha: 0.3,
  );

  static final Color glassShadow = CupertinoColors.black.withValues(
    alpha: 0.05,
  );

  static const Color textPrimary = CupertinoColors.black;
  static const Color textSecondary = CupertinoColors.secondaryLabel;
}
