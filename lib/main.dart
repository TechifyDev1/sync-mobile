import 'package:flutter/cupertino.dart';
import 'package:sync_mobile/core/theme/app_theme.dart';
import 'package:flutter/material.dart' show DefaultMaterialLocalizations;

import 'sync_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const [DefaultMaterialLocalizations.delegate],
      home: SyncApp(),
      theme: AppTheme.cupertinoTheme,
    );
  }
}
