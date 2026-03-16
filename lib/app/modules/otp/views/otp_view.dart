import 'package:automation/app/core/them/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../widgets/custom_button.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 64.w,
      height: 64.w,
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: const Color(0xFF1F2A37),
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.textFieldBorder,),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFF1E5B9C),),
    );

    return Scaffold(
      backgroundColor: const Color(
        0xFFF2F6FA,
      ), // Background color matches login
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: const Color(0xFF1E5B9C),
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Verify Identity',
          style: TextStyle(
            color: const Color(0xFF1F2A37),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60.h),

              // Top Icon
              Center(
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF3FB),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    color: const Color(0xFF1E5B9C),
                    size: 32.sp,
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              // Title
              Text(
                'Enter OTP Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF1F2A37),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12.h),

              // Subtitle
              Text(
                'We sent a verification code to\n+977 **** 1234',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 14.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 40.h),

              // OTP Input
              Center(
                child: Pinput(
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  showCursor: true,
                  onChanged: (value) => controller.otpCode.value = value,
                  onCompleted: (pin) => controller.verify(),
                ),
              ),

              SizedBox(height: 48.h),

              // Verify Button
              CustomButton(onPressed: controller.verify, label: 'Verify'),

              SizedBox(height: 24.h),

              // Resend Text
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){
                        controller.canResend();
                    },
                      child: TextButton(
                        onPressed: controller.canResend.value
                            ? controller.resendCode
                            : null,
                        style: TextButton.styleFrom(
                          foregroundColor: controller.canResend.value
                              ? const Color(0xFF1E5B9C)
                              : const Color(0xFF9CA3AF),
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Resend Code',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (!controller.canResend.value) ...[
                      SizedBox(width: 8.w),
                      Text(
                        '(${controller.resendTimer.value}s)',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
