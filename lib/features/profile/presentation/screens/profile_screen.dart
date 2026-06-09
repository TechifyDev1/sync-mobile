import 'package:flutter/cupertino.dart';

import '../../../../core/extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widget/build_glass_container.dart';
import '../../../../shared/widget/custom_nav_bar.dart';
import '../model/enums.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CustomNavBar(
        title: Text("Profile"),
        trailing: CupertinoButton(
          padding: .zero,
          onPressed: () {},
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: .circle,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            child: const Icon(
              CupertinoIcons.pencil,
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
      child: SingleChildScrollView(
        padding: .all(AppSpacing.lg),
        physics: ClampingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: 0.2,
                      ), // Shadow color
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(width: 2.5, color: AppColors.primary),
                ),
                child: ClipOval(
                  child: Image.network(
                    "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        alignment: .center,
                        child: Text(
                          "JD",
                          style: CupertinoTheme.of(
                            context,
                          ).textTheme.navTitleTextStyle,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),
              BuildGlassContainer(
                // boxShadow: [BoxShadow(color: AppColors.glassShadow)],
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "About".toUpperCase(),
                      style: CupertinoTheme.of(
                        context,
                      ).textTheme.tabLabelTextStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const .all(AppSpacing.sm),
                      width: .infinity,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: .circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies lacinia, nunc nisl aliquam nisl, eget aliquam nunc nisl eget nunc."
                                .truncate(24),
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.pickerTextStyle.copyWith(fontSize: 17),
                          ),
                          Spacer(),
                          CupertinoButton(
                            padding: .zero,
                            child: Icon(
                              CupertinoIcons.pencil,
                              color: AppColors.textSecondary,
                              size: 30,
                              fontWeight: .w900,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _buildAvailabilityContainer(context),
              const SizedBox(height: AppSpacing.md),
              CupertinoButton.filled(
                minimumSize: Size(.infinity, 0),
                child: const Text("Save Status"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityRow({
    required Avalability availability,
    required bool isSelected,
  }) {
    return Container(
      padding: const .all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // BoxShadow(
          //   color: AppColors.primary.withValues(alpha: 0.2),
          //   blurRadius: 10,
          //   spreadRadius: 2,
          //   offset: const Offset(0, 10),
          // ),
        ],
        border: isSelected
            ? BoxBorder.all(color: AppColors.primary, width: 1.5)
            : null,
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: availability == .online
                  ? CupertinoColors.activeGreen.withValues(alpha: 0.15)
                  : availability == .away
                  ? CupertinoColors.activeOrange.withValues(alpha: 0.15)
                  : CupertinoColors.systemRed.withValues(alpha: 0.15),
              shape: BoxShape.circle, // Cleaner than circular(1000)
            ),
            child: Icon(
              availability == .online
                  ? CupertinoIcons.circle_fill
                  : availability == .away
                  ? CupertinoIcons.clock_fill
                  : CupertinoIcons.minus_circle_fill,
              color: availability == .online
                  ? CupertinoColors.activeGreen
                  : availability == .away
                  ? CupertinoColors.activeOrange
                  : CupertinoColors.systemRed,
            ),
          ),
          const SizedBox(width: AppSpacing.sm), // Added space after icon
          Text(
            availability == .online
                ? "Online"
                : availability == .away
                ? "Away"
                : "Do not Disturb",
          ),
          const Spacer(),
          if (isSelected)
            Icon(CupertinoIcons.check_mark_circled, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildAvailabilityContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "Availability".toUpperCase(),
          style: CupertinoTheme.of(context).textTheme.tabLabelTextStyle
              .copyWith(fontSize: 16, color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildAvailabilityRow(availability: .online, isSelected: false),
        const SizedBox(height: AppSpacing.sm),
        _buildAvailabilityRow(availability: .away, isSelected: false),
        const SizedBox(height: AppSpacing.sm),
        _buildAvailabilityRow(availability: .doNotDisturb, isSelected: true),
      ],
    );
  }
}
