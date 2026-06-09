import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sync_mobile/core/theme/app_colors.dart';
import 'package:sync_mobile/core/theme/app_spacing.dart';
import 'package:sync_mobile/features/chat/repository/data.dart';
import 'package:sync_mobile/shared/widget/build_avatar.dart';
import 'package:sync_mobile/shared/widget/custom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CustomNavBar(
        title: const Text("Sync"),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.ellipsis_vertical, fontWeight: .w900),
        ),
      ),
      child: Stack(
        children: [
          // Ambient Gradient Circle
          Positioned(
            top: -50,
            left: -20,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(.circular(300)),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    AppColors.primary.withValues(alpha: 0.08),
                    AppColors.primary.withValues(alpha: 0.03),
                    CupertinoColors.transparent,
                  ],
                  stops: const [0.0, 0.4, 0.7, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SafeArea(
                child: CupertinoListSection.insetGrouped(
                  margin: .zero,
                  backgroundColor: AppColors.background,
                  children: List.generate(mockChatList.length, ((index) {
                    final chats = mockChatList;
                    return CupertinoListTile.notched(
                      backgroundColor: AppColors.background,
                      // backgroundColor: CupertinoColors.transparent,
                      padding: const .symmetric(
                        vertical: AppSpacing.md,
                        horizontal: AppSpacing.sm,
                      ),
                      leading: const BuildAvatar(url: "url"),
                      title: Text(chats[index].name),
                      subtitle: Text(
                        chats[index].lastMessage,
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .tabLabelTextStyle
                            .copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                      ),
                      leadingSize: 50,
                      onTap: () {},
                      trailing: Column(
                        children: [
                          Text(
                            "16:45",
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .tabLabelTextStyle
                                .copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                  fontWeight: .bold,
                                ),
                          ),
                          if (chats[index].unreadCount > 0)
                            ClipOval(
                              child: Container(
                                width: 20,
                                height: 20,
                                color: CupertinoColors.black,
                                alignment: .center,
                                child: Text(
                                  "${chats[index].unreadCount}",
                                  style: const TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  })),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
