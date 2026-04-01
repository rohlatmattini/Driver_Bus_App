// lib/modules/profile/views/widgets/profile_avatar.dart
import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  const ProfileAvatar({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColor.cardColor,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.1), blurRadius: 10)],
            ),
            child: CircleAvatar(
              radius: 55.r,
              backgroundColor: AppColor.primaryGreen.withOpacity(0.1),
              backgroundImage: imageUrl != null ? AssetImage(imageUrl!) : null,
              child: imageUrl == null ? Icon(Icons.person, size: 60.sp, color: AppColor.primaryGreen) : null,
            ),
          ),
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: AppColor.primaryGreen,
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.white, width: 2),
            ),
            child: Icon(Icons.edit, color: Colors.white, size: 14.sp),
          ),
        ],
      ),
    );
  }
}