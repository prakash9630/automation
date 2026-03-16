import 'package:automation/app/core/them/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/student_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class SearchDataListTab extends GetView<DashboardController>  {
  const SearchDataListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchAndFilters(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Align(
            alignment: Alignment.centerRight,
            child: Obx(() => Text(
              "Total: ${controller.students.length}",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.sp,
              ),
            )),
          ),
        ),
        Expanded(
          child: Obx(() => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.students.length,
            itemBuilder: (context, index) {
              return _buildStudentCard(controller.students[index]);
            },
          )),
        ),
      ],
    );
  }
  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search by name...",
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF1E5B9C)),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.filters.map((filter) => _buildFilterChip(filter)).toList(),
            ),
          ),
          SizedBox(height: 8.h),
          Divider(color: Colors.grey[200], thickness: 1.h),
        ],
      ),
    );
  }
  Widget _buildStudentCard(StudentModel student) {
    return InkWell(
      onTap: (){
        Get.toNamed(Routes.RECORD_DETAIL);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.containerBorder),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: student.avatarColor,
              child: Text(
                student.initials,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
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
                    student.name,
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    student.gender,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: student.statusColor,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      student.status,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[300], size: 24.sp),
          ],
        ),
      ),
    );
  }
  Widget _buildFilterChip(String label) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == label;
      return GestureDetector(
        onTap: () => controller.setFilter(label),
        child: Container(
          margin: EdgeInsets.only(right: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E5B9C) : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isSelected ? const Color(0xFF1E5B9C) : const Color(0xFFE0E0E0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    });
  }

}
