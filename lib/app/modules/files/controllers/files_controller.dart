import 'package:get/get.dart';

enum FileType { pdf, jpg }

class FileModel {
  final String name;
  final String size;
  final FileType type;

  FileModel({
    required this.name,
    required this.size,
    required this.type,
  });
}

class FilesController extends GetxController {
  final files = <FileModel>[].obs;
  final totalFilesCount = 0.obs;
  final totalSize = "0 MB".obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockFiles();
    _calculateStats();
  }

  void _loadMockFiles() {
    files.addAll([
      FileModel(name: "TRANSCRIPT", size: "2.1 MB", type: FileType.pdf),
      FileModel(name: "SEE GRADE-SHEET", size: "1.5 MB", type: FileType.jpg),
      FileModel(name: "SEE CHARACTER", size: "890 KB", type: FileType.pdf),
      FileModel(name: "Citizenship", size: "3.2 MB", type: FileType.jpg),
      FileModel(name: "Language Certificate", size: "1.1 MB", type: FileType.pdf),
      FileModel(name: "Tax Verification", size: "750 KB", type: FileType.pdf),
      FileModel(name: "Birth Verification", size: "620 KB", type: FileType.pdf),
    ]);
  }

  void _calculateStats() {
    totalFilesCount.value = 21; // Mock count based on screenshot
    totalSize.value = "27.3 MB"; // Mock size based on screenshot
  }
}
