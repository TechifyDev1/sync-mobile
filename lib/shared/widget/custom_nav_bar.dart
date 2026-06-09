import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sync_mobile/core/theme/app_colors.dart';
import 'package:sync_mobile/core/theme/app_spacing.dart';

class CustomNavBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final bool shouldObstructFully;
  final Size sizePreferred;
  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final bool centerTitle;
  final EdgeInsets padding;
  const CustomNavBar({
    super.key,
    this.leading,
    this.trailing,
    required this.title,
    this.centerTitle = false,
    this.shouldObstructFully = false,
    this.padding = const .all(AppSpacing.sm),
    this.sizePreferred = const Size.fromHeight(70),
  });

  @override
  Widget build(BuildContext context) {
    final bool canNavigateBack = Navigator.canPop(context);
    final double topPadding = MediaQuery.paddingOf(context).top;
    return ClipRRect(
      child: BackdropFilter(
        filter: .blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          width: .infinity,
          height: sizePreferred.height + topPadding,
          padding: padding.copyWith(top: topPadding),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            border: .fromLTRB(
              left: .none,
              right: .none,
              top: .none,
              bottom: BorderSide(color: AppColors.strokeLight, width: 1.5),
            ),
          ),
          child: Align(
            alignment: .bottomCenter,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                if (canNavigateBack)
                  IconButton.outlined(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.back),
                  ),
                ?leading,
                if (centerTitle)
                  DefaultTextStyle(
                    style: CupertinoTheme.of(
                      context,
                    ).textTheme.navLargeTitleTextStyle,
                    child: title,
                  )
                else
                  Expanded(
                    child: DefaultTextStyle(
                      style: CupertinoTheme.of(
                        context,
                      ).textTheme.navLargeTitleTextStyle,
                      child: title,
                    ),
                  ),
                ?trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => sizePreferred;

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return shouldObstructFully;
  }
}
