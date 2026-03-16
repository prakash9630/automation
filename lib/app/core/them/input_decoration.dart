import 'package:automation/app/core/them/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInputDecoration {
  static InputDecoration textInputDecoration({
    String? hintText,
}) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(
        color: AppColors.textFieldBorder,
        fontSize: 16.sp,
      ),
    );
  }


  static InputDecoration passwordDecoration({
    bool hidePassword=true,
    required Function() onHideToggle
  }) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: 'Password',
      hintStyle: TextStyle(
        color: AppColors.textFieldBorder,
        fontSize: 16.sp,
      ),
      suffixIcon: TextButton(
        onPressed:onHideToggle,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF2E85C8),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: Text(
          hidePassword ? 'Show' : 'Hide',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
