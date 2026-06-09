import 'package:flutter/cupertino.dart';

import '../models/enums.dart';

class BuildAvatarWithType extends StatelessWidget {
  const BuildAvatarWithType({super.key, required this.url, required this.type});

  final String url;
  final CallType type;

  @override
  Widget build(BuildContext context) {
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
