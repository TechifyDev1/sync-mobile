import 'package:flutter/cupertino.dart';
import 'package:sync_mobile/core/widgets/main_tab.dart';

class SyncApp extends StatelessWidget {
  final String title;
  const SyncApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MainTab();
  }
}
