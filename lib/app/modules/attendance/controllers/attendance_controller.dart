import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentModel {
  final String name;
  final String initials;
  final Color avatarColor;
  final int presentCount;
  final int absentCount;
  final Rx<AttendanceStatus> status;

  StudentModel({
    required this.name,
    required this.initials,
    required this.avatarColor,
    required this.presentCount,
    required this.absentCount,
    AttendanceStatus initialStatus = AttendanceStatus.none,
  }) : status = initialStatus.obs;
}

enum AttendanceStatus { none, present, absent }

class AttendanceController extends GetxController {
  // Class Details
  final className = "Japanese Language".obs;
  final section = "B7-8 AM".obs;
  final teacher = "Bibek Ghimire".obs;
  final timeSlot = "07:00 AM - 08:00 AM".obs;

  // Students List
  final students = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockStudents();
  }

  void _loadMockStudents() {
    students.addAll([
      StudentModel(
        name: "Sapana Thapa",
        initials: "ST",
        avatarColor: const Color(0xFF4285F4),
        presentCount: 0,
        absentCount: 0,
      ),
      StudentModel(
        name: "Sumitra Pokhrel",
        initials: "SP",
        avatarColor: const Color(0xFFE53935),
        presentCount: 17,
        absentCount: 0,
      ),
    ]);
  }

  void markPresent(int index) {
    students[index].status.value = AttendanceStatus.present;
  }

  void markAbsent(int index) {
    students[index].status.value = AttendanceStatus.absent;
  }
}
