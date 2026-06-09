import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Material;
import 'package:pinput/pinput.dart';
import 'package:sync_mobile/core/theme/app_colors.dart';
import 'package:sync_mobile/core/theme/app_spacing.dart';
import 'package:sync_mobile/shared/widget/build_glass_container.dart';
import 'package:sync_mobile/shared/widget/custom_nav_bar.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();

  PinTheme get _defaultPinTheme => PinTheme(
    width: 54,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    decoration: BoxDecoration(
      color: AppColors.glassSurface,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.strokeDark, width: 1),
      boxShadow: [
        BoxShadow(
          color: AppColors.glassShadow,
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
  );

  PinTheme get _focusedPinTheme => _defaultPinTheme.copyWith(
    decoration: BoxDecoration(
      color: CupertinoColors.white.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.primary, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.12),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
  );

  PinTheme get _submittedPinTheme => _defaultPinTheme.copyWith(
    decoration: BoxDecoration(
      color: CupertinoColors.white.withValues(alpha: 0.72),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.strokeLight, width: 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavBar(title: const Text("Sync")),
      child: Align(
        alignment: .center,
        child: SingleChildScrollView(
          padding: .all(AppSpacing.md),
          physics: ClampingScrollPhysics(),
          child: SafeArea(
            child: BuildGlassContainer(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Verify OTP",
                        style: CupertinoTheme.of(
                          context,
                        ).textTheme.navLargeTitleTextStyle,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Center(
                      child: Text(
                        "A 5 digit key has been sent to j****@email.com",
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                        textAlign: .center,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Material(
                      color: CupertinoColors.transparent,
                      child: Pinput(
                        length: 5,
                        defaultPinTheme: _defaultPinTheme,
                        focusedPinTheme: _focusedPinTheme,
                        submittedPinTheme: _submittedPinTheme,
                        separatorBuilder: (_) =>
                            const SizedBox(width: AppSpacing.sm),
                        showCursor: true,
                        cursor: Container(
                          width: 2,
                          height: 22,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        closeKeyboardWhenCompleted: true,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CupertinoButton.filled(
                      minimumSize: Size(.infinity, 0),
                      child: const Text("Verify otp"),
                      onPressed: () {},
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    CupertinoButton(
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          const Text("Resend Otp"),
                          const SizedBox(width: AppSpacing.xs),
                          Icon(CupertinoIcons.arrow_2_circlepath),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
