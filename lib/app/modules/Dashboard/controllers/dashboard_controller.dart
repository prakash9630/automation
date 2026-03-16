import 'package:automation/app/data/services/storage_helper.dart';
import 'package:automation/app/modules/Dashboard/widget/home_tab.dart';
import 'package:automation/app/modules/Dashboard/widget/notification_tab.dart';
import 'package:automation/app/modules/Dashboard/widget/profile_tab.dart';
import 'package:automation/app/modules/Dashboard/widget/search_data_list_tab.dart';
import 'package:automation/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/dashboard_model.dart';
import '../../../data/models/navigatin_items.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/models/student_model.dart';

class DashboardController extends GetxController {
  final currentIndex = 0.obs;
  final pipelineItems = <PipelineItem>[].obs;
  final actionItems = <ActionItem>[].obs;
  final pinnedData = <DashboardData>[].obs;
  final recentData = <DashboardData>[].obs;
  final selectedIndex = 2.obs;

  //for search
  final students = <StudentModel>[].obs;
  final selectedFilter = "All".obs;
  final filters = ["All", "Inquiry", "Counseled", "Applied", "Enrolled"];

  //for profile
  final userName = "Narayan Nyaupane".obs;
  final userEmail = "narayan@insource.com.np".obs;
  final userInitials = "NN".obs;


  @override
  void onInit() {
    super.onInit();
    _loadMockData();
    _loadMockNotifications();
    _loadMockStudents();
  }
  Widget get currentPage => pages[currentIndex.value];
  String get getTitle => navigationItems[currentIndex.value].label;
  final todayNotifications = <NotificationModel>[].obs;
  final yesterdayNotifications = <NotificationModel>[].obs;


  void _loadMockNotifications() {
    todayNotifications.addAll([
      NotificationModel(
        userName: "Sanchita Kunwar",
        userInitials: "SK",
        avatarColor: const Color(0xFF4285F4),
        time: "2h",
        action: "mentioned you in a comment",
        subject: "Sapana Thapa",
        isUnread: true,
      ),
      NotificationModel(
        userName: "Narayan Nyaupane",
        userInitials: "NN",
        avatarColor: const Color(0xFF34A853),
        time: "5h",
        action: "assigned you as data manager",
        subject: "Bipana Khadka",
        isUnread: true,
      ),
      NotificationModel(
        userName: "System",
        userInitials: "S",
        avatarColor: const Color(0xFFFBBC05),
        time: "6h",
        action: "Task due date",
        subject: "Review documents",
        isUnread: false,
      ),
    ]);

    yesterdayNotifications.addAll([
      NotificationModel(
        userName: "Bibek Ghimire",
        userInitials: "BG",
        avatarColor: const Color(0xFFA142F4),
        time: "1d",
        action: "posted an activity",
        subject: "Daily Report",
        isUnread: false,
      ),
      NotificationModel(
        userName: "Sanchita Kunwar",
        userInitials: "SK",
        avatarColor: const Color(0xFF34A853),
        time: "1d",
        action: "approved your activity",
        subject: "Task Update",
        isUnread: false,
      ),
    ]);
  }

  void markAllRead() {
    for (var n in todayNotifications) {
      // Create new instances since it's an obs list
      todayNotifications[todayNotifications.indexOf(n)] = NotificationModel(
        userName: n.userName,
        userInitials: n.userInitials,
        avatarColor: n.avatarColor,
        time: n.time,
        action: n.action,
        subject: n.subject,
        isUnread: false,
      );
    }
  }

  void _loadMockData() {
    pipelineItems.addAll([
      PipelineItem(10, 'Inquiry', const Color(0xFF4A8BEE)),
      PipelineItem(3, 'Counseled', const Color(0xFF48BB78)),
      PipelineItem(0, 'Enrolled', const Color(0xFFED8936)),
      PipelineItem(3, 'Applied', const Color(0xFF9F7AEA)),
    ]);

    actionItems.addAll([
      ActionItem('Attendance', '📋'),
      ActionItem('Visitor', '🧑‍💼'),
      ActionItem('Payment', '💰'),
    ]);

    pinnedData.addAll([
      DashboardData(
        initials: 'ST',
        title: 'Sapana Thapa',
        subTitle: 'Demo',
        color: const Color(0xFF4A8BEE),
        isPinned: true,
      ),
      DashboardData(
        initials: 'GM',
        title: 'Global Mgmt Foundation',
        subTitle: 'AMC Manager',
        color: const Color(0xFF9F7AEA),
        isPinned: true,
      ),
    ]);

    recentData.addAll([
      DashboardData(
        initials: 'ST',
        title: 'Sapana Thapa',
        subTitle: 'Demo',
        color: const Color(0xFF4A8BEE),
        timestamp: '12h ago',
      ),
      DashboardData(
        initials: 'DB',
        title: 'Divya Bishwakarma',
        subTitle: 'Demo',
        color: const Color(0xFFED64A6), // Pinkish
        timestamp: '12h ago',
      ),
      DashboardData(
        initials: 'MT',
        title: 'Muskan Tiruwa',
        subTitle: 'Demo',
        color: const Color(0xFF48BB78),
        timestamp: '2d ago',
      ),
    ]);
  }

  void changeBottomNav(int index) {
    currentIndex.value = index;
  }

  final List<Widget> pages = [
    const HomeTab(),
    const SearchDataListTab(),
    const NotificationTab(),
    const ProfileTab(),

  ];


  void _loadMockStudents() {
    students.addAll([
      StudentModel(
        name: "Sapana Thapa",
        initials: "ST",
        gender: "Female",
        status: "Counseled",
        avatarColor: const Color(0xFF4285F4),
        statusColor: const Color(0xFF34A853),
      ),
      StudentModel(
        name: "Bipana Khadka",
        initials: "BK",
        gender: "Female",
        status: "Inquiry",
        avatarColor: const Color(0xFF34A853),
        statusColor: const Color(0xFF1E5B9C),
      ),
      StudentModel(
        name: "Kanchan Bishwakarma",
        initials: "KB",
        gender: "Female",
        status: "Counseled",
        avatarColor: const Color(0xFF34A853),
        statusColor: const Color(0xFF34A853),
      ),
      StudentModel(
        name: "Saroj Pokhrel",
        initials: "SP",
        gender: "Male",
        status: "Applied",
        avatarColor: const Color(0xFF34A853),
        statusColor: const Color(0xFFA142F4),
      ),
      StudentModel(
        name: "Pushpa Gotame",
        initials: "PG",
        gender: "Female",
        status: "Inquiry",
        avatarColor: const Color(0xFF34A853),
        statusColor: const Color(0xFF1E5B9C),
      ),
      StudentModel(
        name: "Sumitra Pokhrel",
        initials: "SP",
        gender: "Female",
        status: "Counseled",
        avatarColor: const Color(0xFFE53935),
        statusColor: const Color(0xFF34A853),
      ),
    ]);
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }



  void logout() {
     StorageHelper.clear();
    Get.offAll(Routes.LOGIN);
    Get.snackbar(
      "Logout",
      "You have been logged out",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateTo(String screen) {
    print("Navigating to $screen");
  }

  List<NavigationItems> navigationItems=[
    NavigationItems(icon: Icons.home_outlined, label: "Home", activeIcon: Icons.home),
    NavigationItems(icon: Icons.search, label: "Search", activeIcon: Icons.search),
    NavigationItems(icon: Icons.notifications_outlined, label: "Notification", activeIcon: Icons.notifications),
    NavigationItems(icon: Icons.person_outline, label: "Profile", activeIcon: Icons.person),

  ];
}
