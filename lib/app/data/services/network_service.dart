import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  bool _isDialogOpen = false;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // connectivity_plus 6.x returns a list of results
    if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      _showNoInternetDialog();
    } else {
      _hideNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    if (_isDialogOpen) return;

    _isDialogOpen = true;
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.red),
              SizedBox(width: 10),
              Text('No Internet Connection'),
            ],
          ),
          content: const Text(
            'Please check your internet connection and try again.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _hideNoInternetDialog() {
    if (!_isDialogOpen) return;

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    _isDialogOpen = false;
  }
}
