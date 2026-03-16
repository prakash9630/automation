import 'package:automation/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/them/app_color.dart';
import '../../../data/models/dashboard_model.dart';
import '../controllers/dashboard_controller.dart';

class HomeTab extends GetView<DashboardController> {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(color: const Color(0xFFE5E7EB), height: 1.h),
          // Subtle divider

          // PIPELINE
          _buildSectionHeader('PIPELINE'),
          _buildPipelineSlider(),

          SizedBox(height: 16.h),

          // ACTIONS
          _buildActionsGrid(),

          SizedBox(height: 24.h),

          // PINNED DATA
          _buildSectionHeader('📌 PINNED DATA', isIconSubbed: true),
          _buildListSection(controller.pinnedData, isPinnedList: true),

          SizedBox(height: 24.h),

          // RECENTLY VIEWED
          _buildSectionHeader('🕒 RECENTLY VIEWED', isIconSubbed: true),
          _buildListSection(controller.recentData),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool isIconSubbed = false}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildPipelineSlider() {
    return Column(
      children: [
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: controller.pipelineItems.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final item = controller.pipelineItems[index];
              return InkWell(
                onTap: (){
                  Get.toNamed(Routes.RECORD_DETAIL);
                },
                child: Container(
                  width: 90.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: item.color.withAlpha(76), // ~0.3 opacity
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${item.count}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        // Custom Scroll Indicator Mock
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(3.r),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.6, // Represents current scroll
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionsGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.actionItems.map((item) {
          return Expanded(
            child: InkWell(
              onTap: (){
                if(item.title=="Attendance"){
                  Get.toNamed(Routes.ATTENDANCE);
                }
                else if(item.title=="Visitor"){
                  Get.toNamed(Routes.VISITOR);
                }
                else if(item.title=="Payment"){
                  Get.toNamed(Routes.PAYMENT);
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.containerBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(item.iconPath, style: TextStyle(fontSize: 28.sp)),
                    SizedBox(height: 12.h),
                    Text(
                      item.title,
                      style: TextStyle(
                        color: const Color(0xFF6B7280),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListSection(
    List<DashboardData> dataList, {
    bool isPinnedList = false,
  }) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dataList.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final data = dataList[index];
        return InkWell(
          onTap: (){
            Get.toNamed(Routes.RECORD_DETAIL);
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.containerBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: data.color,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    data.initials,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          color: const Color(0xFF1F2A37),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        data.subTitle,
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isPinnedList)
                  Icon(
                    Icons.push_pin,
                    color: const Color(0xFFEF4444), // Red
                    size: 20.sp,
                  )
                else if (data.timestamp != null)
                  Text(
                    data.timestamp!,
                    style: TextStyle(
                      color: const Color(0xFFD1D5DB),
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
