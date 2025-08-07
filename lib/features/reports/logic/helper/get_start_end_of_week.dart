DateTime getWeekStart(DateTime today) {
  final int daysSinceSaturday = today.weekday % 7;
  return DateTime(today.year, today.month, today.day - daysSinceSaturday);
}

DateTime getWeekEnd(DateTime weekStart) {
  return weekStart.add(const Duration(days: 6));
}
