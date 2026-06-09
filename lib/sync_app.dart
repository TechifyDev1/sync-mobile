import 'package:flutter/cupertino.dart';
import 'package:sync_mobile/features/auth/presentation/screen/auth_screen.dart';
import 'package:sync_mobile/features/auth/presentation/screen/otp_screen.dart';
import 'package:sync_mobile/features/auth/presentation/widget/cupertino_form_example.dart';

class SyncApp extends StatelessWidget {
  const SyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpScreen();
  }
}
