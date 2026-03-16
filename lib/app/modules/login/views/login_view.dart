import 'package:automation/app/core/them/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FA), // Match background color from design
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80.h),
              
              // Logo
              Center(
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E5B9C), // Dark blue
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E5B9C).withAlpha(51), // withOpacity(0.2)
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Title
              Text(
                'AUTOMATION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF1F2A37),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                ),
              ),
              
              SizedBox(height: 8.h),
              
              // Subtitle
              Text(
                'Transforming your business',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              SizedBox(height: 48.h),
              
              // Username Label
              Text(
                'Username / Email',
                style: TextStyle(
                  color: const Color(0xFF4B5563),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: 8.h),
              
              // Username TextField
              TextField(
                controller: controller.usernameController,
                decoration:AppInputDecoration.textInputDecoration(hintText: 'narayan@insource.com.np'),
              ),
              
              SizedBox(height: 24.h),
              
              // Password Label
              Text(
                'Password',
                style: TextStyle(
                  color: const Color(0xFF4B5563),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: 8.h),
              
              // Password TextField
              Obx(() => TextField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                decoration: AppInputDecoration.passwordDecoration(
                    hidePassword: controller.isPasswordHidden.value, onHideToggle: () {
                  controller.isPasswordHidden.value=!controller.isPasswordHidden.value;

                })
              )),
              
              SizedBox(height: 48.h),
              
              // Login Button
              CustomButton(
                onPressed: controller.login,
                label: 'Login',
              ),
              
              SizedBox(height: 24.h),
              
              // Forgot Password
              TextButton(
                onPressed: () {
                  // Implement functionality
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF2E85C8), 
                ),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
