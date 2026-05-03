import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../controllers/passenger_controller.dart';

class TicketDetailsDialog extends StatelessWidget {
  const TicketDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PassengerController>();
    final passenger = controller.currentScannedPassenger.value;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.white,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, passenger?.id ?? "N/A"),
          SizedBox(height: 24.h),
          _buildInfoRow(context, "passenger".tr, passenger?.name ?? "Unknown"),
          _buildInfoRow(
            context,
            "route".tr,
            passenger?.route ?? "Not Specified",
          ),
          _buildInfoRow(context, "seat".tr, passenger?.seatNumber ?? "--"),
          _buildInfoRow(
            context,
            "status".tr,
            passenger?.isPaid == true ? "Paid" : "Unpaid",
          ),
          SizedBox(height: 30.h),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String ticketId) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColor.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_circle, color: AppColor.success, size: 40.sp),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ticketVerified".tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: context.black,
                ),
              ),
              Text(
                "ID: $ticketId",
                style: TextStyle(fontSize: 12.sp, color: context.grey),
              ),
            ],
          ),
        ),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.primaryGreen,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        "VERIFIED",
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: context.grey, fontSize: 14.sp),
          ),
          Text(
            value,
            style: TextStyle(
              color: context.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Get.back();
              Get.toNamed(AppRoutes.qrScanner);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryGreen,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              "nextScan".tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
