// lib/modules/auth/login/views/widgets/login_background.dart
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_color.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.scaffoldBackground,
      ),
      child: child,
    );
  }
}