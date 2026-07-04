class DateFormatter {
  static String today() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }
}
