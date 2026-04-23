// lib/modules/passenger/views/widgets/route_info_card.dart
import 'package:driver_bus_app/core/constants/app_color.dart';
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
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColor.grey.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.02), blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoColumn("ROUTE".tr, "Cairo → Alexandria", CrossAxisAlignment.start),
          _buildInfoColumn("DEPARTURE".tr, "10:00 AM", CrossAxisAlignment.end),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(title, style: TextStyle(fontSize: 10.sp, color: AppColor.grey, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColor.primaryGreen)),
      ],
    );
  }
}