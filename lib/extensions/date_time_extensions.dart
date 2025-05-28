extension DateTimeExtensions on DateTime {
  /// Returns a [List] of [DateTime] for the current week.
  static List<DateTime> get currentWeekDates {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
    return List.generate(
      endOfWeek.difference(startOfWeek).inDays + 1,
      (index) => startOfWeek.add(Duration(days: index)),
    );
  }
}
