import 'dart:io';

import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () => controller.pickImage(),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: context.cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.cardColor.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Obx(
                () => CircleAvatar(
                  radius: 55.r,
                  backgroundColor: AppColor.primaryGreen.withOpacity(0.1),
                  backgroundImage: controller.profileImagePath.value.isNotEmpty
                      ? FileImage(File(controller.profileImagePath.value))
                      : null,
                  child: controller.profileImagePath.value.isEmpty
                      ? Icon(
                          Icons.person,
                          size: 60.sp,
                          color: AppColor.primaryGreen,
                        )
                      : null,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.pickImage(),
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColor.primaryGreen,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).cardColor,
                  width: 2,
                ),
              ),
              child: Icon(Icons.edit, color: Colors.white, size: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
