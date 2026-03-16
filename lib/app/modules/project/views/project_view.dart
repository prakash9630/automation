import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../routes/app_pages.dart';
import '../controllers/project_controller.dart';
import '../../../data/models/project_model.dart';

class ProjectView extends GetView<ProjectController> {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FA), // Match background color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Select Project',
          style: TextStyle(
            color: const Color(0xFF1F2A37),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false, // Usually no back button on home
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 16.h),
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.searchProjects,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search projects...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color(0xFF9CA3AF),
                    size: 20.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: const Color(0xFFE5E7EB),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: const Color(0xFF1E5B9C),
                    ),
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 8.h),
              child: Text(
                'RECENT PROJECTS',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            
            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  itemCount: controller.filteredProjects.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final project = controller.filteredProjects[index];
                    return _buildProjectCard(project);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(ProjectModel project) {
    return GestureDetector(
      onLongPress: () => controller.toggleFavorite(project.id),
      onTap: () {

        Get.toNamed(Routes.DASHBOARD);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5), // extremely subtle shadow
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar Placeholder
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: project.color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Text(
                project.initials,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(width: 16.w),
            
            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: TextStyle(
                      color: const Color(0xFF1F2A37),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    project.company,
                    style: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            
            // Star Icon
            Obx(() {
              if (project.isFavorite.value) {
                return Icon(
                  Icons.star,
                  color: const Color(0xFFF5A623), // Orange Star
                  size: 24.sp,
                );
              }
              return const SizedBox.shrink();
            }),
            
            SizedBox(width: 8.w),
            
            // Chevron
            Icon(
              Icons.chevron_right,
              color: const Color(0xFFD1D5DB),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
