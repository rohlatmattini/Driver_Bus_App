import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';

class InfoGridCards extends StatelessWidget {
  final String title;
  final String value;
  final bool isStatus;

  const InfoGridCards({
    super.key,
    required this.title,
    required this.value,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: context.textPrimaryColor.withOpacity(0.02),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: context.textTertiaryColor,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                if (isStatus)
                  Icon(Icons.circle, color: AppColor.success, size: 8.sp),
                if (isStatus) SizedBox(width: 6.w),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: isStatus
                        ? AppColor.success
                        : context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
