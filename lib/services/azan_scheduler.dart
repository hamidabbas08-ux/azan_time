import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'location_service.dart';
import 'notification_service.dart';
import 'prayer_service.dart';

class AzanScheduler {
  AzanScheduler._();

  static final AzanScheduler instance = AzanScheduler._();

  final PrayerService _prayerService = PrayerService();
  final LocationService _locationService = LocationService();

  Future<void> scheduleToday() async {
    final position = await _locationService.getLocation();

    final timings = await _prayerService.getPrayerTimes(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    await _schedulePrayer(
      id: 1,
      name: 'Fajr',
      time: timings['Fajr'],
    );

    await _schedulePrayer(
      id: 2,
      name: 'Dhuhr',
      time: timings['Dhuhr'],
    );

    await _schedulePrayer(
      id: 3,
      name: 'Asr',
      time: timings['Asr'],
    );

    await _schedulePrayer(
      id: 4,
      name: 'Maghrib',
      time: timings['Maghrib'],
    );

    await _schedulePrayer(
      id: 5,
      name: 'Isha',
      time: timings['Isha'],
    );
  }

  Future<void> _schedulePrayer({
    required int id,
    required String name,
    required String time,
  }) async {
    final parts = time.split(':');

    final now = DateTime.now();

    final prayerTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );

    if (prayerTime.isBefore(now)) return;

    await AndroidAlarmManager.oneShotAt(
      prayerTime,
      id,
      _alarmCallback,
      exact: true,
      wakeup: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _alarmCallback() async {
    await NotificationService.instance.showPrayerNotification(
      title: 'Prayer Time',
      body: 'اذان کا وقت ہوگیا ہے',
    );
  }
}
