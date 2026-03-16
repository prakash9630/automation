import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E5B9C)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Class Attendance',
          style: TextStyle(
            color: const Color(0xFF333333),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(height: 1.h, thickness: 1.h, color: Colors.grey[100]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildClassHeader(),
            SizedBox(height: 24.h),
            Obx(() => Text(
                  "STUDENTS (${controller.students.length})",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                )),
            SizedBox(height: 12.h),
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.students.length,
                  itemBuilder: (context, index) {
                    return _buildStudentCard(index, controller.students[index]);
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildClassHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E5B9C),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
                controller.className.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(height: 4.h),
          Obx(() => Text(
                "${controller.section.value} • ${controller.teacher.value}",
                style: TextStyle(
                  color: Colors.white.withAlpha(204), // withOpacity(0.8)
                  fontSize: 12.sp,
                ),
              )),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.white.withAlpha(153), size: 16.sp),
              SizedBox(width: 8.w),
              Obx(() => Text(
                    controller.timeSlot.value,
                    style: TextStyle(
                      color: Colors.white.withAlpha(204), // withOpacity(0.8)
                      fontSize: 12.sp,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(int index, StudentModel student) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFEBF3F9)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: student.avatarColor,
                child: Text(
                  student.initials,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 12.sp),
                        children: [
                          TextSpan(
                            text: "P: ${student.presentCount}",
                            style: const TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "  •  ",
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                          TextSpan(
                            text: "A: ${student.absentCount}",
                            style: const TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  final isSelected = student.status.value == AttendanceStatus.present;
                  return _buildActionButton(
                    label: "✓ Present",
                    color: const Color(0xFF4CAF50),
                    isSelected: isSelected,
                    onTap: () => controller.markPresent(index),
                  );
                }),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Obx(() {
                  final isSelected = student.status.value == AttendanceStatus.absent;
                  return _buildActionButton(
                    label: "✗ Absent",
                    color: const Color(0xFFE53935),
                    isSelected: isSelected,
                    onTap: () => controller.markAbsent(index),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(25) : Colors.transparent, // withOpacity(0.1)
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
