import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';

/// extension for TimeOfDay
extension TimeOfDayExtension on TimeOfDay? {
  /// Convert [TimeOfDay] to [String]
  String? get formatTimeOfDay =>
      this == null ? null : '${this?.hour}:${this?.minute}';

  /// Convert [TimeOfDay] to [String]
  String get format12Hour {
    return '${this?.hourOfPeriod.timeFormat}:${this?.minute.timeFormat}';
  }

  /// Convert [TimeOfDay] to [String]
  String format12HourWithPeriod(BuildContext context) {
    TimeOfDay? time = this?.replacing(hour: this?.hourOfPeriod);
    MaterialLocalizations localizations = MaterialLocalizations.of(context);

    final StringBuffer buffer = StringBuffer();

    buffer
      ..write(time?.format(context))
      ..write(' ')
      ..write(this?.period == DayPeriod.am
          ? localizations.anteMeridiemAbbreviation
          : localizations.postMeridiemAbbreviation);

    return buffer.toString();
  }

  /// Add [hour] and [minute] to [TimeOfDay]
  TimeOfDay add({int hour = 0, int minute = 0}) {
    return TimeOfDay.fromDateTime(DateTime.now()
        .copyWith(hour: this?.hour, minute: this?.minute)
        .add(Duration(hours: hour, minutes: minute)));
  }

  /// Subtract [hour] and [minute] to [TimeOfDay]
  TimeOfDay subtract({int hour = 0, int minute = 0}) {
    return TimeOfDay.fromDateTime(DateTime.now()
        .copyWith(hour: this?.hour, minute: this?.minute)
        .subtract(Duration(hours: hour, minutes: minute)));
  }

  /// Get difference between [TimeOfDay]
  Duration difference(TimeOfDay? other) {
    return DateTime.now()
        .copyWith(hour: this?.hour, minute: this?.minute)
        .difference(
            DateTime.now().copyWith(hour: other?.hour, minute: other?.minute));
  }

  /// Convert [TimeOfDay] to [DateTime]
  DateTime get toDate => DateTime.now().copyWith(
        hour: this?.hour,
        minute: this?.minute,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

  /// Convert [TimeOfDay] to [DateTime] as end of minute
  DateTime get toDateAsEndOfMinute => DateTime.now().copyWith(
        hour: this?.hour,
        minute: this?.minute,
        second: 59,
        millisecond: 0,
        microsecond: 0,
      );
}
