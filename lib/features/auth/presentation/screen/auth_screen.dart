import 'package:dio/dio.dart';
import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:sync_mobile/core/network/app_error.dart';
import 'package:sync_mobile/core/theme/app_colors.dart';
import 'package:sync_mobile/shared/widget/build_glass_container.dart';
import 'package:sync_mobile/shared/widget/custom_nav_bar.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../repository/auth_repo.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _authRepo = AuthRepo();
  bool _agreeToTerms = false;
  void getOtp() async {
    try {
      final email = await _authRepo.getOtp(
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
      );
    } on DioException catch (e) {
      dev.log(e.toString());
      final AppError error = e.error as AppError;
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: ((context) {
            return CupertinoAlertDialog(
              title: Text(error.title),
              content: Text(error.message),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("Ok"),
                ),
              ],
            );
          }),
        );
      }
    } catch (e) {
      dev.log(e.toString());
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: ((context) {
            return CupertinoAlertDialog(
              title: Text("Unknown Exception"),
              content: Text(e.toString()),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("Ok"),
                ),
              ],
            );
          }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
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
                        "Authenticate!",
                        style: CupertinoTheme.of(
                          context,
                        ).textTheme.navLargeTitleTextStyle,
                      ),
                    ),
                    CupertinoFormSection.insetGrouped(
                      header: const Text("EMAIL"),
                      decoration: BoxDecoration(
                        border: .all(color: AppColors.strokeDark),
                        borderRadius: .all(.circular(18)),
                      ),
                      children: [
                        CupertinoTextFormFieldRow(
                          controller: _emailController,
                          prefix: Icon(CupertinoIcons.envelope),
                          placeholder: "johndoe@email.com",
                          keyboardType: .emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email address is required';
                            }
                            final emailRegExp = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegExp.hasMatch(value.trim())) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    CupertinoFormSection.insetGrouped(
                      header: const Text("PHONE"),
                      decoration: BoxDecoration(
                        border: .all(color: AppColors.strokeDark),
                        borderRadius: .all(.circular(18)),
                      ),
                      children: [
                        CupertinoTextFormFieldRow(
                          controller: _phoneNumberController,
                          prefix: Icon(CupertinoIcons.phone),
                          placeholder: "123794565689",
                          keyboardType: .phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Phone number is required';
                            }
                            final digitsOnly = value.replaceAll(
                              RegExp(r'\D'),
                              '',
                            );
                            if (digitsOnly.length < 8 ||
                                digitsOnly.length > 15) {
                              return 'Enter a valid phone (8-15 digits)';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    CupertinoFormSection.insetGrouped(
                      header: const Text("PREFERENCE"),
                      footer: const Text(
                        "By checking the above box, you're agreeing to our terms of service.",
                      ),
                      decoration: BoxDecoration(
                        border: .all(color: AppColors.strokeDark),
                        borderRadius: .all(.circular(18)),
                      ),
                      children: [
                        CupertinoFormRow(
                          prefix: const Text("Agree to terms"),
                          child: CupertinoSwitch(
                            activeTrackColor: AppColors.primary,
                            value: _agreeToTerms,
                            onChanged: (bool value) {
                              setState(() {
                                _agreeToTerms = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const .symmetric(horizontal: 16.0),
                      child: CupertinoButton.filled(
                        minimumSize: Size(.infinity, 0),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: .center,
                          children: [
                            const Text('Send OTP'),
                            const SizedBox(width: AppSpacing.md),
                            Icon(CupertinoIcons.paperplane),
                          ],
                        ),
                      ),
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
