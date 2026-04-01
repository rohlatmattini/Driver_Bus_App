// lib/modules/auth/forgot_password/views/forgot_password_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_color.dart';
import '../../../../../core/shared/custom_button.dart';
import '../../../../../core/shared/custom_text_field.dart';
import '../../controllers/forget_password_controller.dart';

class ForgotPasswordView extends GetView<ForgetPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),

              _buildTopIcon(),

              SizedBox(height: 25.h),

              Text(
                "forgotPasswordTitle".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColor.black),
              ),

              SizedBox(height: 10.h),

              Text(
                "forgotPasswordDesc".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: AppColor.grey),
              ),

              SizedBox(height: 30.h),

              CustomTextField(
                controller: controller.emailController,
                hint: "emailOrUser".tr,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "pleaseEnterEmail".tr;
                  if (!GetUtils.isEmail(value)) return "pleaseEnterValidEmail".tr;
                  return null;
                }, label:"emailOrUser".tr,
              ),

              SizedBox(height: 35.h),

              Obx(() => CustomAppButton(
                text: "sendCode".tr,
                isLoading: controller.isLoading.value,
                onPressed: () => controller.sendResetCode(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: CircleAvatar(
          backgroundColor: AppColor.cardColor,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
      ),
    );
  }

  Widget _buildTopIcon() {
    return Icon(
      Icons.lock_reset,
      size: 120.sp,
      color: AppColor.primaryGreen,
    );
  }


}