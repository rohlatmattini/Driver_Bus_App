import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_color.dart';

class SendComplaintButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SendComplaintButton({
    super.key,
    required this.onPressed,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryGreen,
        minimumSize: Size(double.infinity, 55.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
        height: 20.h,
        width: 20.h,
        child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      )
          : Text(
        "send".tr,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}