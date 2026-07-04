class LocationHelper {
  static String format(String city, String country) {
    if (country.isEmpty) return city;
    return '$city, $country';
  }
}
