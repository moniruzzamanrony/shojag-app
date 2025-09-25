import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// extension for DateTime
extension DateTimeExtension on DateTime {
  /// Convert [DateTime] to [TimeOfDay]
  TimeOfDay get toTimeOfDay => TimeOfDay(hour: hour, minute: minute);

  /// Convert [DateTime] to start of the day
  DateTime get dayStartTime =>
      copyWith(hour: 0, minute: 0, second: 0, millisecond: 1);

  /// Convert [DateTime] to end of the day
  DateTime get dayEndTime =>
      copyWith(hour: 23, minute: 59, second: 59, millisecond: 0);

  /// Convert [DateTime] to local [DateTime],
  /// and format it to [pattern].
  ///
  /// Here [pattern] is required
  String formatDate({required String pattern}) {
    return DateFormat(pattern).format(toLocal());
  }

  /// Check if [DateTime] is same as [other]
  bool isSameDay({DateTime? other}) {
    other ??= DateTime.now();
    return year == other.year && month == other.month && day == other.day;
  }

  /// Check if [DateTime] is same as same month as [other]
  bool isSameMonth({DateTime? other}) {
    other ??= DateTime.now();
    return year == other.year && month == other.month;
  }

  /// Check if [DateTime] is same as same year as [other]
  bool isSameYear({DateTime? other}) {
    other ??= DateTime.now();
    return year == other.year;
  }

  /// Check if [DateTime] is same as same hour as [other]
  bool isSameHour({DateTime? other}) {
    other ??= DateTime.now();
    return hour == other.hour;
  }

  /// Check if [DateTime] is same as same minute as [other]
  bool isSameMinute({DateTime? other}) {
    other ??= DateTime.now();
    return minute == other.minute;
  }
}
