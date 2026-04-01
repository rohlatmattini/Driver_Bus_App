// lib/modules/auth/login/views/widgets/login_footer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_color.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'accountManagedBy'.tr,
            style: TextStyle(
              color: AppColor.grey,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'admin'.tr,
            style: TextStyle(
              color: AppColor.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}