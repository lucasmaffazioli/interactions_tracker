extension DateTimeExtension on DateTime {
  DateTime finalDayMoment() {
    return DateTime(this.year, this.month, this.day, 23, 59, 59, 999);
  }

  DateTime initialDayMoment() {
    return DateTime(this.year, this.month, this.day, 0, 0, 0, 0);
  }
}
