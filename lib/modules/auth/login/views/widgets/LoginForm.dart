// lib/modules/auth/login/views/widgets/login_form.dart
import 'package:driver_bus_app/routes/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_color.dart';
import '../../controllers/login_controller.dart';
import '../../../../../core/shared/custom_text_field.dart';
import '../../../../../core/shared/custom_button.dart';

class LoginForm extends StatelessWidget {
  final LoginController controller;

  const LoginForm({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.1),
            blurRadius: 20.r,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: controller.usernameController,
              label: 'usernameOrEmployeeId'.tr,
              hint: 'e.g. DRV-88293',
              icon: Icons.person_outline,
            ),
            SizedBox(height: 20.h),
            Obx(
                  () => CustomTextField(
                controller: controller.passwordController,
                label: 'password'.tr,
                hint: '********',
                icon: Icons.lock_outline,
                isPassword: true,
                obscure: !controller.isPasswordVisible.value,
                onIconTap: controller.togglePasswordVisibility,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {Get.toNamed(AppRoutes.forgetPassword);},
                child: Text(
                  'forgotPassword'.tr,
                  style: TextStyle(
                    color: AppColor.primaryGreen,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Obx(() => CustomAppButton(
              text: 'login'.tr,
              isLoading: controller.isLoading.value,
              onPressed: () => controller.login(),
            )),
          ],
        ),
      ),
    );
  }
}