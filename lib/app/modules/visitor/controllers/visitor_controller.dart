import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitorController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  final selectedGender = "".obs;
  final selectedDistrict = "".obs;
  final assignedUser = "".obs;

  final genders = ["Male", "Female", "Other"];
  final districts = ["Kathmandu", "Lalitpur", "Bhaktapur", "Pokhara", "Chitwan"];
  final users = ["Admin", "Manager", "Receptionist", "Staff"];

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.onClose();
  }

  String? validateEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName cannot be empty";
    }
    return null;
  }

  String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Please select $fieldName";
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return "Mobile number cannot be empty";
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return "Enter a valid 10-digit mobile number";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    if (!GetUtils.isEmail(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  void saveVisitor() {
    if (formKey.currentState!.validate()) {
      Get.snackbar(
        "Success",
        "Visitor saved successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Logic for saving data would go here
    } else {
      Get.snackbar(
        "Error",
        "Please fix the errors in the form",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
