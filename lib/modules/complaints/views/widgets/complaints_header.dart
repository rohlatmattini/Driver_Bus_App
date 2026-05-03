import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ComplaintsHeader extends StatelessWidget {
  const ComplaintsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "howCanWeHelp".tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: context.black,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "complaintDesc".tr,
          style: TextStyle(fontSize: 14.sp, color: context.grey),
        ),
      ],
    );
  }
}
