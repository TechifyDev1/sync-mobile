import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shapes.dart';
import '../../core/theme/app_spacing.dart';

class BuildGlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final BoxBorder border;
  final BorderRadius borderRadius;
  final List<BoxShadow> boxShadow;
  BuildGlassContainer({
    super.key,
    required this.child,
    this.padding = const .all(AppSpacing.md),
    List<BoxShadow>? boxShadow,

    BorderRadius? borderRadius,
    BoxBorder? border,
  }) : border = border ?? .all(color: AppColors.strokeLight, width: 1),
       borderRadius = borderRadius ?? AppShapes.cardRadius,
       boxShadow =
           boxShadow ??
           [
             BoxShadow(
               color: AppColors.glassShadow,
               blurRadius: 20,
               spreadRadius: 1,
             ),
           ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // 1. Move the shadow to an outer container so it doesn't get clipped or blurred
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15.0,
            sigmaY: 15.0,
          ), // Slightly reduced blur for clarity on white
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: borderRadius,
              border: border,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
