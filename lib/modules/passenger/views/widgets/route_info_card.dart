import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RouteInfoCard extends StatelessWidget {
  const RouteInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: context.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: context.black.withOpacity(0.02), blurRadius: 5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoColumn(
            context,
            "ROUTE".tr,
            "Cairo → Alexandria",
            CrossAxisAlignment.start,
          ),
          _buildInfoColumn(
            context,
            "DEPARTURE".tr,
            "10:00 AM",
            CrossAxisAlignment.end,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(
    BuildContext context,
    String title,
    String value,
    CrossAxisAlignment alignment,
  ) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            color: context.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryGreen,
          ),
        ),
      ],
    );
  }
}
