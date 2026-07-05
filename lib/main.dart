import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';
import 'services/azan_scheduler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();
  await NotificationService.instance.initialize();
  await AzanScheduler.instance.scheduleToday();

  runApp(const AzanTimeApp());
}

class AzanTimeApp extends StatelessWidget {
  const AzanTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azan Time',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
