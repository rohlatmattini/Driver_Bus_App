// lib/modules/auth/login/views/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool obscure;
  final VoidCallback? onIconTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.obscure = false,
    this.onIconTap,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.primaryGreen,
          selectionColor: AppColor.primaryGreen.withOpacity(0.3),
          selectionHandleColor: AppColor.primaryGreen,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        keyboardType: keyboardType,
        cursorColor: AppColor.primaryGreen,
        style: TextStyle(color: AppColor.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColor.grey),
          floatingLabelStyle: const TextStyle(color: AppColor.primaryGreen),
          hintText: hint,
          hintStyle: TextStyle(color: AppColor.grey),
          prefixIcon: Icon(icon, color: AppColor.greyText, size: 22.sp),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              obscure ? Icons.visibility : Icons.visibility_off,
              size: 20.sp,
              color: obscure ? AppColor.greyText : AppColor.primaryGreen,
            ),
            onPressed: onIconTap,
          )
              : null,
          filled: true,
          fillColor: AppColor.fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: AppColor.primaryGreen,
              width: 2.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}