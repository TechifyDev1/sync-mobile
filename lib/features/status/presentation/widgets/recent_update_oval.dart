import 'package:flutter/cupertino.dart';

import '../../../../core/extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class RecentUpdateOval extends StatelessWidget {
  final String name;
  const RecentUpdateOval(Key? key, {required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> nameSplits = name.trim().split(" ");
    String displayName;
    if (nameSplits.length > 1) {
      displayName = nameSplits[0].truncate(7);
    } else {
      displayName = name.truncate(7);
    }
    final size = MediaQuery.sizeOf(context).width * 0.24;

    return Column(
      mainAxisAlignment: .center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: .circle,
            color: AppColors.onPrimary,
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textSecondary,
              shape: .circle,
            ),
            margin: .all(4),
            child: Center(
              child: Text(
                name[0],
                style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
                    .copyWith(
                      color: AppColors.onPrimary,
                      fontSize: 32,
                      fontWeight: .bold,
                    ),
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),
        Text(displayName),
      ],
    );
  }
}
