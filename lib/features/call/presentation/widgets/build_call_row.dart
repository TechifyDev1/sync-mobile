import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../models/enums.dart';

class BuildCallRow extends StatelessWidget {
  const BuildCallRow({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarSize = MediaQuery.of(context).size.width * 0.13;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          _buildAvatarWithType(type: .dialed, avatarSize: avatarSize),
          const SizedBox(width: AppSpacing.md),
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: const [
              Text(
                "John Doe",
                style: TextStyle(fontSize: 18, fontWeight: .w600),
              ),
              Text(
                "Yesterday, 8:30 PM",
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
          const Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: _buildCallModeIcon(mode: .video),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarWithType({
    required CallType type,
    required double avatarSize,
  }) {
    return Stack(
      children: [
        Container(
          height: avatarSize,
          width: avatarSize,
          decoration: BoxDecoration(
            shape: .circle,
            color: const Color(0xFFBDBDBD),
            border: Border.all(color: const Color(0xFF9E9E9E), width: 2),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
              ),
              fit: .cover,
            ),
          ),
          child: const Center(child: Text("JD")),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconTheme(
            data: IconThemeData(
              color: CupertinoColors.white,
              size: avatarSize * 0.35,
            ),
            child: _determineIcon(type: type),
          ),
        ),
      ],
    );
  }

  Widget _determineIcon({required CallType type}) {
    switch (type) {
      case .missed:
        return const Icon(
          CupertinoIcons.phone_badge_plus,
          color: Color(0xFFE53935),
          fontWeight: .w600,
        );
      case .dialed:
        return const Icon(
          CupertinoIcons.phone_arrow_up_right,
          color: AppColors.primary,
          fontWeight: .w600,
        );
      case .received:
        return const Icon(
          CupertinoIcons.phone_arrow_down_left,
          color: AppColors.primary,
          fontWeight: .w600,
        );
    }
  }

  Widget _buildCallModeIcon({required CallMode mode}) {
    switch (mode) {
      case .audio:
        return const Icon(
          CupertinoIcons.phone,
          color: AppColors.primary,
          fontWeight: .w600,
        );
      case .video:
        return const Icon(
          CupertinoIcons.videocam,
          color: AppColors.primary,
          fontWeight: .w600,
        );
    }
  }
}
