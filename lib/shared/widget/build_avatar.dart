import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

class BuildAvatar extends StatelessWidget {
  final String url;
  const BuildAvatar({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        loadingBuilder: (context, child, loadingProgress) {
          return ClipOval(child: CupertinoActivityIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          developer.log(error.toString());
          return ClipOval(
            child: Icon(CupertinoIcons.person_alt_circle, size: 50),
          );
        },
      ),
    );
  }
}
