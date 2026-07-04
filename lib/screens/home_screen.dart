import 'package:flutter/material.dart';

import '../services/location_service.dart';
import '../services/prayer_service.dart';
import '../services/azan_scheduler.dart';
import '../widgets/prayer_card.dart';
import '../widgets/countdown_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService locationService = LocationService();
  final PrayerService prayerService = PrayerService();

  Map<String, dynamic> timings = {};

  String city = 'Loading...';
  String country = '';

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      loading = true;
    });

    try {
      final position = await locationService.getLocation();

      final data = await prayerService.getPrayerTimes(

        latitude: position.latitude,

        longitude: position.longitude,

      );

      await AzanScheduler.instance.scheduleToday();


      setState(() {
        timings = data;
        city = 'Current Location';
        country = '';
        loading = false;
      });
    } catch (e) {
      setState(() {
        city = 'Location Error';
        country = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Azan Time'),
      ),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              city,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (country.isNotEmpty)
              Text(
                country,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            const CountdownCard(
              title: 'Next Prayer',
              countdown: '--:--:--',
            ),
            const SizedBox(height: 20),
            PrayerCard(
              name: 'Fajr',
              time: timings['Fajr'] ?? '--',
            ),
            PrayerCard(
              name: 'Dhuhr',
              time: timings['Dhuhr'] ?? '--',
            ),
            PrayerCard(
              name: 'Asr',
              time: timings['Asr'] ?? '--',
            ),
            PrayerCard(
              name: 'Maghrib',
              time: timings['Maghrib'] ?? '--',
            ),
            PrayerCard(
              name: 'Isha',
              time: timings['Isha'] ?? '--',
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: loadData,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh Location'),
            ),
          ],
        ),
      ),
    );
  }
}
