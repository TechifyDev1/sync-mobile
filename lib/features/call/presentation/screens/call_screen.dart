import 'package:flutter/cupertino.dart';
import 'package:sync_mobile/core/theme/app_colors.dart';
import 'package:sync_mobile/core/theme/app_spacing.dart';
import 'package:sync_mobile/shared/widget/custom_nav_bar.dart';

import '../models/enums.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CustomNavBar(
        title: const Text("Calls"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.black,
            ),
            child: const Icon(
              CupertinoIcons.plus,
              color: AppColors.onPrimary,
              size: 18,
            ),
          ),
        ),
      ),
      child: Stack(
        children: [
          // 1. Ambient Gradient Circle (Matches HomeScreen)
          Positioned(
            top: -50,
            left: -20,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(300)),
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

          // 2. Grouped List View Content Area
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SafeArea(
                child: CupertinoListSection.insetGrouped(
                  header: Text(
                    "Call history".toUpperCase(),
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navActionTextStyle
                        .copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF757575),
                        ),
                  ),
                  margin: .zero,
                  backgroundColor: AppColors.background,
                  decoration: BoxDecoration(
                    color: AppColors.glassSurface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  children: List.generate(13, (index) {
                    // Mock varying statuses for visual reference
                    final type = index % 3 == 0
                        ? CallType.missed
                        : (index % 3 == 1
                              ? CallType.dialed
                              : CallType.received);
                    final mode = index % 2 == 0
                        ? CallMode.video
                        : CallMode.audio;

                    return CupertinoListTile.notched(
                      backgroundColor: AppColors.background,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                        horizontal: AppSpacing.sm,
                      ),
                      leadingSize: 50,
                      leading: _buildAvatarWithType(
                        url: "https://unsplash.com",
                        type: type,
                      ),
                      title: const Text(
                        "John Doe",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Text(
                        "Yesterday, 8:30 PM",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      additionalInfo: CupertinoButton(
                        padding: .zero,
                        onPressed: () {},
                        child: Icon(
                          mode == .video
                              ? CupertinoIcons.videocam
                              : CupertinoIcons.phone,
                          color: type == .missed
                              ? const Color(0xFFE53935)
                              : AppColors.primary,
                          size: 24,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Optimized helper to build the contextual phone status badge over the avatar
  Widget _buildAvatarWithType({required String url, required CallType type}) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CupertinoColors.systemGrey5, width: 1),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: -2,
          right: -2,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              type == CallType.missed
                  ? CupertinoIcons.phone_badge_plus
                  : (type == CallType.dialed
                        ? CupertinoIcons.phone_arrow_up_right
                        : CupertinoIcons.phone_arrow_down_left),
              color: type == CallType.missed
                  ? const Color(0xFFE53935)
                  : CupertinoColors.black,
              size: 14,
            ),
          ),
        ),
      ],
    );
  }
}
