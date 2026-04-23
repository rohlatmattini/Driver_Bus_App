import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_color.dart';

class ComplaintTextField extends StatelessWidget {
  final TextEditingController controller;

  const ComplaintTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.primaryGreen,
      controller: controller,
      maxLines: 8,
      textAlignVertical: TextAlignVertical.top,
      style: TextStyle(fontSize: 14.sp, color: AppColor.black),
      decoration: InputDecoration(
        hintText: "writeYourComplaint".tr,
        hintStyle: TextStyle(color: AppColor.grey.withOpacity(0.5)),
        fillColor: AppColor.cardColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColor.primaryGreen),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColor.primaryGreen, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColor.primaryGreen, width: 1.0),
        ),

      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "pleaseWriteSomething".tr;
        }
        return null;
      },
    );
  }
}