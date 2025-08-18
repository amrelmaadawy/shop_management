DateTime getWeekStart(DateTime today) {
  int diff = today.weekday - DateTime.saturday;
  if (diff < 0) diff += 7; 
  return today.subtract(Duration(days: diff));
}


DateTime getWeekEnd(DateTime weekStart) {
  return weekStart.add(const Duration(days: 6));
}
