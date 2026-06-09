import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show IconButton;
import 'package:sync_mobile/features/chat/presentation/data/mock_data.dart';
import 'package:sync_mobile/features/status/presentation/widgets/recent_update_oval.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widget/build_glass_container.dart';
import '../../../../shared/widget/custom_nav_bar.dart';

class StatusScreen extends StatelessWidget {
  StatusScreen({super.key});
  final unViewedStatuses = statusLists
      .where((status) => !status.isViewed)
      .toList();
  final viewedStatuses = statusLists
      .where((status) => status.isViewed)
      .toList();

  @override
  Widget build(BuildContext context) {
    final double viewedStatusHeight = MediaQuery.sizeOf(context).height * 0.15;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CustomNavBar(
        title: const Text("Status"),
        trailing: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.search, fontWeight: .w900),
              tooltip: "Search",
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.ellipsis_vertical, fontWeight: .w900),
              tooltip: "More",
            ),
          ],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: .topCenter,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const .symmetric(horizontal: 16, vertical: 8),
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    BuildGlassContainer(
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: .circle,
                              color: AppColors.primaryContainer,
                            ),
                            child: const Icon(
                              CupertinoIcons.add,
                              color: CupertinoColors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: .start,
                            children: const [
                              Text(
                                "My Status",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: .w600,
                                ),
                              ),
                              Text(
                                "Tap to add status update",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Align(
                      alignment: .centerLeft,
                      child: Text(
                        "Recent Updates",
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      height: viewedStatusHeight,
                      width: .infinity,
                      child: ListView.builder(
                        itemCount: unViewedStatuses.length,
                        scrollDirection: .horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.sm,
                            ),
                            child: RecentUpdateOval(
                              key,
                              name: unViewedStatuses[index].name,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Align(
                      alignment: .centerLeft,
                      child: Text(
                        "Viewed Updates",
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...List.generate(viewedStatuses.length, (index) {
                      return Column(
                        crossAxisAlignment: .start,
                        children: [
                          CupertinoButton.filled(
                            padding: .zero,
                            color: AppColors.glassSurface,
                            onPressed: () {},
                            child: BuildGlassContainer(
                              child: Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.onPrimary,
                                      border: .all(
                                        color: AppColors.textSecondary,
                                        width: 2,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColors.textSecondary,
                                        shape: BoxShape.circle,
                                      ),
                                      margin: const .all(4),
                                      child: Center(
                                        child: Text(
                                          viewedStatuses[index].name[0],
                                          style: CupertinoTheme.of(context)
                                              .textTheme
                                              .navTitleTextStyle
                                              .copyWith(
                                                color: AppColors.onPrimary,
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      Text(
                                        viewedStatuses[index].name,
                                        style: CupertinoTheme.of(context)
                                            .textTheme
                                            .navTitleTextStyle
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: .w600,
                                              color: AppColors.textPrimary,
                                            ),
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      const Text(
                                        "Yesterday, 11:15PM",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
