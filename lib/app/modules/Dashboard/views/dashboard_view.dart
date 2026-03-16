import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.getTitle,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          if(controller.getTitle=="Notification")
          Column(
            children: [
              TextButton(
                onPressed: controller.markAllRead,
                child: Text(
                  "Mark all read",
                  style: TextStyle(
                    color: const Color(0xFF1E5B9C),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
          ),

        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(height: 1.h, thickness: 1.h, color: Colors.grey[100]),
        ),
      ),
      body: Obx(() => controller.currentPage),

      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeBottomNav,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF1E5B9C),
            unselectedItemColor: const Color(0xFF9CA3AF),
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(fontSize: 12.sp),
            items: controller.navigationItems.map((e) {
              return BottomNavigationBarItem(
                icon: e.label != "Notification"
                    ? Icon(e.icon)
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(e.icon),
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                activeIcon: Icon(e.activeIcon),
                label: e.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
