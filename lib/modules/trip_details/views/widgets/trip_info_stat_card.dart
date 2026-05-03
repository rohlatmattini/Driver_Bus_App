import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';

class TripInfoStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const TripInfoStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(color: context.cardColor.withOpacity(0.02), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: context.textTertiaryColor, fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(icon, size: 20.sp, color: AppColor.primaryGreen),
              SizedBox(width: 8.w),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
