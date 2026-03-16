import 'package:automation/app/core/them/them_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';
import 'app/data/services/storage_service.dart';
import 'app/data/services/network_service.dart';
import 'app/data/services/network_connection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialConfig();
  runApp(const MyApp());
}

Future<void> initialConfig() async {
  await Get.putAsync(() => StorageService().init());
  Get.put(NetworkService(), permanent: true);
  Get.put(NetworkConnection(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'automation test',
          debugShowCheckedModeBanner: false,
          theme:appTheme,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
