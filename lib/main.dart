import 'package:alarmapp/constants/app_colors.dart';
import 'package:alarmapp/features/home/alarms/alarm_controller.dart';
import 'package:alarmapp/features/location/controllers/location_controller.dart';
import 'package:alarmapp/helpers/notification_helper.dart';
import 'package:alarmapp/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  await NotificationHelper.initialize();  // Initialize notifications

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.onboarding,
      getPages: AppPages.pages,
      initialBinding: BindingsBuilder(() {
        Get.put(AlarmController());
        Get.put(LocationController());
      }),
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: AppColors.accentColor,
        scaffoldBackgroundColor: AppColors.background,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
