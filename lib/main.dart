import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show DefaultMaterialLocalizations;

import 'core/storage/hive/hive_storage.dart';
import 'core/theme/app_theme.dart';
import 'sync_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveStorage().initAndOpenAllBoxes();
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
