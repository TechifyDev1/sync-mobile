import 'package:flutter/cupertino.dart';
import 'package:sync_mobile/features/call/presentation/screens/call_screen.dart';
import 'package:sync_mobile/features/chat/presentation/screens/home_screen.dart';
import 'package:sync_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:sync_mobile/features/status/presentation/screens/status_screen.dart';
import 'package:sync_mobile/shared/widget/build_glass_container.dart';

import '../theme/app_colors.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  int _currentIndex = 0;

  final screens = [
    const HomeScreen(),
    StatusScreen(),
    const CallScreen(),
    const ProfileScreen(),
  ];

  // Helper definition to keep code clean
  final List<Map<String, dynamic>> _navItems = [
    {'icon': CupertinoIcons.chat_bubble_2_fill, 'label': 'Chats'},
    {'icon': CupertinoIcons.circle_filled, 'label': 'Status'},
    {'icon': CupertinoIcons.phone_fill, 'label': 'Calls'},
    {'icon': CupertinoIcons.person_fill, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: screens),

          // Floating Circular Navigation Bar
          Positioned(
            left: 24,
            right: 24,
            bottom: 0,
            child: SafeArea(
              child: BuildGlassContainer(
                padding: const .symmetric(vertical: 8, horizontal: 16),
                border: Border.all(color: AppColors.strokeLight, width: 0.5),
                borderRadius: .circular(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_navItems.length, (index) {
                    final bool isSelected = _currentIndex == index;

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setState(() => _currentIndex = index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _navItems[index]['icon'],
                              size: 24,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _navItems[index]['label'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
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
}
