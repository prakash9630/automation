import 'package:get/get.dart';
import 'storage_service.dart';

class NetworkConnection extends GetConnect {
  final StorageService _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    // Base URL Setup
    baseUrl = 'https://api.yourdomain.com/v1'; // Change this to your base URL
    timeout = const Duration(seconds: 30);

    // Request Modifier: Attach Token
    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await _storageService.read('access_token');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    // Authenticator: Refresh Token Logic (Handles 401)
    httpClient.addAuthenticator<dynamic>((request) async {
      final response = await post('/auth/refresh', {
        'refresh_token': await _storageService.read('refresh_token'),
      });

      if (response.statusCode == 200) {
        final newToken = response.body['access_token'];
        final newRefreshToken = response.body['refresh_token'];

        await _storageService.write('access_token', newToken);
        await _storageService.write('refresh_token', newRefreshToken);

        // Update current request header and retry
        request.headers['Authorization'] = 'Bearer $newToken';
        return request;
      } else {
        // Refresh token failed, maybe redirect to login
        Get.offAllNamed('/login');
        return request;
      }
    });

    // Response Modifier: Centralized Error Handling
    httpClient.addResponseModifier((request, response) {
      if (!response.isOk) {
        _handleError(response);
      }
      return response;
    });

    super.onInit();
  }

  void _handleError(Response response) {
    String message = 'Something went wrong';
    
    switch (response.statusCode) {
      case 400:
        message = response.body['message'] ?? 'Bad Request';
        break;
      case 403:
        message = 'Forbidden Access';
        break;
      case 404:
        message = 'Resource not found';
        break;
      case 500:
        message = 'Internal Server Error';
        break;
      default:
        if (response.statusText != null && response.statusText!.isNotEmpty) {
          message = response.statusText!;
        }
    }

    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.errorContainer,
      colorText: Get.theme.colorScheme.onErrorContainer,
    );
  }
}
