import 'package:driver_bus_app/core/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_image.dart';
import '../../../../../core/shared/custom_button.dart';
import '../../../../../core/shared/verification_code_field.dart';
import '../../../../../core/shared/custom_text_field.dart';
import '../../controllers/forget_password_controller.dart';

class ResetPasswordScreen extends GetView<ForgetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading:  BackButton(color: AppColor.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImageAsset.forget_password,
                  width: double.infinity,
                  height: 250.h,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: AppColor.primaryGreen, height: 350.h),
                ),

                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Transform.translate(
              offset: Offset(0, -50.h),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "***",
                      style: TextStyle(
                        fontSize: 45.sp,
                        color: AppColor.primaryGreen,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                      ),
                    ),

                    Text(
                      'resetPassword'.tr,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryGreen,
                      ),
                    ),
                    SizedBox(height: 10.h),
                     Text('enterCodeSent'.tr),
                    SizedBox(height: 30.h),
                    const VerificationCodeField(),
                    SizedBox(height: 20.h),
                    // داخل ResetPasswordScreen
                    CustomTextField(
                      controller: controller.passwordController,
                      hint: 'newPassword'.tr,
                      icon: Icons.lock_outline,
                      isPassword: true,
                      obscure:true,
                     // onIconTap: () => controller.togglePasswordVisibility(),
                      validator: (value) {
                        if (value!.length < 6) return 'passwordTooShort'.tr;
                        return null;
                      }, label: 'newPassword'.tr,
                    ),

                    SizedBox(height: 15.h),

                    CustomTextField(
                      controller: controller.confirmPasswordController,
                      hint: 'confirmPassword'.tr,
                      icon: Icons.lock_reset,
                      isPassword: true,
                      obscure: true, // مثلاً
                      validator: (value) {
                        if (value != controller.passwordController.text) return 'passwordsNotMatch'.tr;
                        return null;
                      }, label: 'confirmPassword'.tr,
                    ),
                    SizedBox(height: 30.h),
                    CustomAppButton(
                      text: "resetPasswordButton".tr,
                      onPressed: () => controller.resetPassword(),
                    ),
                    SizedBox(height: 15.h),
                    TextButton(
                      onPressed: () {
                        /* Logic */
                      },
                      child: Text(
                        'resendCode'.tr,
                        style: TextStyle(
                          color: AppColor.primaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
