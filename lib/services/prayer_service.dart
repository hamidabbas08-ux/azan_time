import 'dart:convert';

import 'package:http/http.dart' as http;

class PrayerService {
  Future<Map<String, dynamic>> getPrayerTimes({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      'https://api.aladhan.com/v1/timings?latitude=$latitude&longitude=$longitude&method=2',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load prayer times');
    }

    final json = jsonDecode(response.body);

    return Map<String, dynamic>.from(
      json['data']['timings'],
    );
  }
}
