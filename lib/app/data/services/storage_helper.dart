import 'package:get/get.dart';
import 'storage_service.dart';

class StorageHelper {
  // Private constructor to prevent instantiation
  StorageHelper._();

  // Get the storage service instance
  static StorageService get _storage => Get.find<StorageService>();

  /// Store data - usage: StorageHelper.store('key', 'value')
  static Future<void> store(String key, String value) async {
    await _storage.write(key, value);
  }

  /// Get data - usage: StorageHelper.get('key')
  static Future<String?> get(String key) async {
    return await _storage.read(key);
  }

  /// Delete data - usage: StorageHelper.remove('key')
  static Future<void> remove(String key) async {
    await _storage.delete(key);
  }

  /// Clear all data - usage: StorageHelper.clear()
  static Future<void> clear() async {
    await _storage.clearAll();
  }

  /// Check if key exists - usage: StorageHelper.has('key')
  static Future<bool> has(String key) async {
    return await _storage.containsKey(key);
  }
}