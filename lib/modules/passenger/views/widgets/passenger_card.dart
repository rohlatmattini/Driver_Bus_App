// lib/modules/passenger/views/widgets/passenger_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../data/models/passenger_model.dart';

class PassengerCard extends StatelessWidget {
  final PassengerModel passenger;
  const PassengerCard({super.key, required this.passenger});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.02), blurRadius: 5)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.primaryGreen.withOpacity(0.1),
            child: Text(
              passenger.seatNumber,
              style: TextStyle(color: AppColor.primaryGreen, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(passenger.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColor.black)),
                Text("ID: ${passenger.id}", style: TextStyle(color: AppColor.grey, fontSize: 11.sp)),
              ],
            ),
          ),
          _buildStatusTag(),
        ],
      ),
    );
  }

  Widget _buildStatusTag() {
    final isPaid = passenger.isPaid;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isPaid ? AppColor.success.withOpacity(0.1) : AppColor.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        isPaid ? "PAID".tr : "UNPAID".tr,
        style: TextStyle(
          color: isPaid ? AppColor.success : AppColor.error,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}