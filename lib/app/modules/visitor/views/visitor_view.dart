import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/visitor_controller.dart';

class VisitorView extends GetView<VisitorController> {
  const VisitorView({super.key});
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
        title: Text(
          'Visitor Entry',
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
        padding: EdgeInsets.all(20.r),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Visitor Name *"),
              _buildTextField(
                controller: controller.nameController,
                hintText: "Enter visitor name",
                validator: (value) => controller.validateEmpty(value, "Visitor Name"),
              ),
              SizedBox(height: 20.h),
              _buildLabel("Gender *"),
              _buildDropdown(
                hint: "Select...",
                items: controller.genders,
                onChanged: (val) => controller.selectedGender.value = val ?? "",
                validator: (val) => controller.validateDropdown(val, "Gender"),
              ),
              SizedBox(height: 20.h),
              _buildLabel("District"),
              _buildDropdown(
                hint: "Select...",
                items: controller.districts,
                onChanged: (val) => controller.selectedDistrict.value = val ?? "",
                validator: (val) => controller.validateDropdown(val, "District"),
              ),
              SizedBox(height: 20.h),
              _buildLabel("Mobile Number"),
              _buildTextField(
                controller: controller.mobileController,
                hintText: "98xxxxxxxx",
                keyboardType: TextInputType.phone,
                validator: (value) => controller.validateMobile(value),
              ),
              SizedBox(height: 20.h),
              _buildLabel("Email"),
              _buildTextField(
                controller: controller.emailController,
                hintText: "email@example.com",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => controller.validateEmail(value),
              ),
              SizedBox(height: 20.h),
              _buildLabel("Assign to User"),
              _buildDropdown(
                hint: "Select user...",
                items: controller.users,
                onChanged: (val) => controller.assignedUser.value = val ?? "",
                validator: (val) => controller.validateDropdown(val, "Assign to User"),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                height: 45.h,
                child: ElevatedButton(
                  onPressed: controller.saveVisitor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34A853),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 1,
                  ),
                  child: Text(
                    "Save Visitor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(fontSize: 14.sp, color: const Color(0xFF333333)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      hint: Text(hint, style: TextStyle(color: Colors.grey[400], fontSize: 14.sp)),
      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[400]),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF333333))),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
