// lib/modules/auth/login/views/screen/login_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';
import '../widgets/LoginForm.dart';
import '../widgets/LoginLogo.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_header.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginHeader(),
                LoginForm(controller: controller),
                SizedBox(height: 40.h),
                const LoginFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}