import 'dart:async';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final otpCode = ''.obs;

  final resendTimer = 60.obs;
  final canResend = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

  }

  void onResendCode(){
    canResend.value=false;
    startTimer();
  }

  void startTimer() {
    resendTimer.value = 60;
    canResend.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        canResend.value = true;
        _timer?.cancel();
      }
    });
  }

  void resendCode() {
    if (canResend.value) {
      // Implement resend logic
      startTimer();
    }
  }

  void verify() {
    if (otpCode.value.length == 4) {
      Get.offAllNamed('/project');
    } else {
      Get.snackbar('Error', 'Please enter a valid 4-digit code.');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
