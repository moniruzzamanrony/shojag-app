// this file [datetime_helper.dart] is used for datetime helper functions
// It contains different datetime formats and datetime helper functions
// It has the following functions:
// 1. getCurrentDateTime
// 2. getCurrentDateTimeZero
// 3. getCurrentTimeOfDay
// 4. getDateTimeFromString
// 5. getDateTimeFromTimeOfDay
// 6. getFormattedDateFromString
// 7. getTimeOfDayFromDate
// 8. getTimeOfDayFromString
// 9. getDateTimeFromString


import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String pattern_dd = 'dd';
const String pattern_MMM = 'MMM';
const String pattern_MMMM = 'MMMM';
const String pattern_MMMyy = 'MMM, yy';
const String pattern_MMMyyyy = 'MMM, yyyy';
const String pattern_MMMMyy = 'MMMM, yy';
const String pattern_yyyy = 'yyyy';
const String pattern_ddMMMyyyy = 'dd MMM yyyy';
const String pattern_ddMMMMyyyy = 'dd MMMM yyyy';
const String pattern_ddMMMyy = 'dd MMM yy';
const String pattern_dd_MM_yyyy = 'dd/MM/yyyy';
const String pattern_HHmm = 'HH:mm';
const String pattern_hhmmssa = 'hh:mm:ss a';
const String pattern_hhmma = 'hh:mm a';
const String pattern_ddMMMyhhmma = 'dd MMM yy hh:mm a';
const String pattern_ddMMMyyyhhmma = 'dd MMM yyyy hh:mm a';
const String pattern_ddMMMMyyyhhmma = 'dd MMMM yyyy hh:mm a';
const String pattern_ddMMMyyyHHmm = 'dd MMM yyyy HH:mm';
const String pattern_YYYYMMdd = 'yyyy-MM-dd';
const String pattern_YYYYMMddhhmmss = 'yyyy-MM-dd hh:mm:ss';
const String pattern_YYYYMMddHHmmss = 'yyyy-MM-dd HH:mm:ss';

DateTime get getCurrentDateTime => DateTime.now();

DateTime get getCurrentDateTimeZero => DateTime.now()
    .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

TimeOfDay get getCurrentTimeOfDay => TimeOfDay.now();

String? getFormattedDateFromString(
    {required String? date, String pattern = pattern_ddMMMyyyy}) {
  if (date == null) {
    return null;
  }
  try {
    final dateTime = DateTime.parse(date);
    return dateTime.formatDate(pattern: pattern);
  } catch (e) {
    return null;
  }
}

DateTime? getDateTimeFromTimeOfDay({
  required TimeOfDay? timeOfDay,
}) {
  if (timeOfDay == null) {
    return null;
  }

  final dateTime = DateTime.now().copyWith(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
      second: 0,
      microsecond: 0,
      millisecond: 0);
  return dateTime;
}

DateTime? getDateTimeFromString({
  required String? date,
}) {
  if (date == null || date.isEmpty) {
    return null;
  }
  try {
    final dateTime = DateTime.parse(date);
    return dateTime;
  } catch (e) {
    return null;
  }
}

TimeOfDay? getTimeOfDayFromDate({required DateTime? date}) {
  if (date == null) {
    return null;
  }
  try {
    return TimeOfDay.fromDateTime(date);
  } catch (e) {
    return null;
  }
}

TimeOfDay? getTimeOfDayFromString(
    {required String? date, String sourceFormat = 'HH:mm'}) {
  if (date == null) {
    return null;
  }

  try {
    DateFormat timeFormat = DateFormat(sourceFormat);
    final dateTime = timeFormat.parse(date);
    return TimeOfDay.fromDateTime(dateTime);
  } catch (e) {
    return null;
  }
}
