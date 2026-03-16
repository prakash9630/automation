import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class ProfileTab extends GetView<DashboardController>  {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildMenuItem("My Projects", Icons.chevron_right, () => controller.navigateTo("My Projects")),
              _buildMenuItem("Noticeboard", Icons.chevron_right, () => controller.navigateTo("Noticeboard")),
              _buildMenuItem("Change Password", Icons.chevron_right, () => controller.navigateTo("Change Password")),
              _buildMenuItem("Notification Settings", Icons.chevron_right, () => controller.navigateTo("Notification Settings")),
              _buildMenuItem("App Settings", Icons.chevron_right, () => controller.navigateTo("App Settings")),
              _buildMenuItem("About Automation", Icons.chevron_right, () => controller.navigateTo("About Automation")),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: OutlinedButton(
                  onPressed: () => controller.logout(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE53935)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: const Color(0xFFFFF5F5),
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: const Color(0xFFE53935),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      decoration: const BoxDecoration(
        color: Color(0xFF1E5B9C),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: Colors.white.withAlpha(51), // withOpacity(0.2)
            child: Obx(() => Text(
              controller.userInitials.value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          SizedBox(height: 16.h),
          Obx(() => Text(
            controller.userName.value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(height: 4.h),
          Obx(() => Text(
            controller.userEmail.value,
            style: TextStyle(
              color: Colors.white.withAlpha(179), // withOpacity(0.7)
              fontSize: 14.sp,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData trailingIcon, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
          title: Text(
            title,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(trailingIcon, color: Colors.grey[400], size: 20.sp),
          onTap: onTap,
        ),
        Divider(height: 1.h, thickness: 1.h, color: Colors.grey[100]),
      ],
    );
  }
}
