import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/files_controller.dart';

class FilesView extends GetView<FilesController> {
  const FilesView({super.key});
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
          'Attachments',
          style: TextStyle(
            color: const Color(0xFF333333),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.cloud_upload_outlined, color: const Color(0xFF1E5B9C), size: 20.sp),
            label: Text(
              "Upload",
              style: TextStyle(
                color: const Color(0xFF1E5B9C),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(height: 1.h, thickness: 1.h, color: Colors.grey[200]),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Obx(() => Text(
                  "${controller.totalFilesCount.value} files • ${controller.totalSize.value}",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13.sp,
                  ),
                )),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.files.length,
                  itemBuilder: (context, index) {
                    final file = controller.files[index];
                    return _buildFileItem(file);
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem(FileModel file) {
    final bool isPdf = file.type == FileType.pdf;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEBF3F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: isPdf ? const Color(0xFFFFF5F5) : const Color(0xFFF0F7FF),
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              isPdf ? "PDF" : "JPG",
              style: TextStyle(
                color: isPdf ? const Color(0xFFE53935) : const Color(0xFF1E5B9C),
                fontSize: 10.sp,
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
                  file.name,
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  file.size,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.visibility_outlined, color: Colors.grey[600], size: 20.sp),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_downward, color: Colors.black, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
