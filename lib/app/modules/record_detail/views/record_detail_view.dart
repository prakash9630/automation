import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/record_detail_controller.dart';

class RecordDetailView extends GetView<RecordDetailController> {
  const RecordDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E5B9C)),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
              controller.recordName.value,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            )),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
            onPressed: () {
              Get.toNamed(Routes.COMMENTS);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            _buildStatsGrid(),
            SizedBox(height: 16.h),
            _buildTabBar(),
            _buildInfoList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1E5B9C),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.r,
            backgroundColor: Colors.white.withAlpha(51), // withOpacity(0.2)
            child: Text(
              "ST",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Obx(() => Text(
                controller.recordName.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(height: 4.h),
          Obx(() => Text(
                "#ID: ${controller.recordId.value} • Regd: ${controller.regdDate.value}",
                style: TextStyle(
                  color: Colors.white.withAlpha(204), // withOpacity(0.8)
                  fontSize: 12.sp,
                ),
              )),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Obx(() => Text(
                  controller.status.value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 2.2,
        children: [
          _buildStatCard("Payable", controller.payable.value, const Color(0xFF1E5B9C), const Color(0xFFF0F7FF)),
          _buildStatCard("Paid", controller.paid.value, const Color(0xFF4CAF50), const Color(0xFFF2FAF2)),
          _buildStatCard("Due", controller.due.value, const Color(0xFFE53935), const Color(0xFFFFF5F5)),
          _buildStatCard("Manager", controller.manager.value, const Color(0xFF9C27B0), const Color(0xFFF9F2FB)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color textColor, Color bgColor) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ["Home", "Family", "Income", "Classes", "Files"];
    return Column(
      children: [
        SizedBox(
          height: 40.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: tabs.length,
            separatorBuilder: (context, index) => SizedBox(width: 24.w),
            itemBuilder: (context, index) {
              return Obx(() {
                final isSelected = controller.selectedTab.value == index;
                return GestureDetector(
                  onTap: () => controller.changeTab(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tabs[index],
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF1E5B9C) : Colors.grey,
                          fontSize: 14.sp,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: EdgeInsets.only(top: 4.h),
                          height: 2.h,
                          width: 40.w,
                          color: const Color(0xFF1E5B9C),
                        ),
                    ],
                  ),
                );
              });
            },
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }

  Widget _buildInfoList() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          _buildInfoItem("FIRST NAME", "Sapana"),
          _buildInfoItem("LAST NAME", "Thapa"),
          _buildInfoItem("GENDER", "Female"),
          _buildInfoItem("MARITAL STATUS", "Married"),
          _buildInfoItem("NAME IN JAPANESE", "ビパナ・タパ"),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
