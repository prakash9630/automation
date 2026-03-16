import 'package:get/get.dart';

import '../controllers/record_detail_controller.dart';

class RecordDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordDetailController>(
      () => RecordDetailController(),
    );
  }
}
