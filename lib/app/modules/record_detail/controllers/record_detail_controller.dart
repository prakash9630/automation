import 'package:get/get.dart';

class RecordDetailController extends GetxController {
  final count = 0.obs;
  
  // Tab index for the horizontal tab bar
  final selectedTab = 0.obs;

  // Mock data for the screen
  final recordName = "Sapana Thapa".obs;
  final recordId = "48477".obs;
  final regdDate = "May 26, 2022".obs;
  final status = "Counseled".obs;
  
  final payable = "48,500".obs;
  final paid = "140,000".obs;
  final due = "-91,500".obs;
  final manager = "Sanchita K.".obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
