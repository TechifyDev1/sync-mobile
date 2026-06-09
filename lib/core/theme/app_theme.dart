import 'package:flutter/cupertino.dart';
import 'package:sync_mobile/core/theme/app_colors.dart';

class AppTheme {
  static CupertinoThemeData get cupertinoTheme {
    return CupertinoThemeData(
      brightness: .light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      barBackgroundColor: AppColors.glassSurface,
      textTheme: CupertinoTextThemeData(
        // Global primary font style
        textStyle: TextStyle(
          fontFamily: '.SF Pro Display',
          fontSize: 16,
          height: 1.5,
          color: AppColors.primary,
        ),

        // name: display / h1 mapped to Cupertino action/nav targets
        navLargeTitleTextStyle: TextStyle(
          fontSize: 32,
          fontWeight: .w600,
          height: 1.2,
          letterSpacing: -0.32,
          color: AppColors.primary,
        ),
        navTitleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: .w600,
          height: 1.3,
        ),

        // name: label-md mapped to picker/action text
        pickerTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
      ),
    );
  }
}
