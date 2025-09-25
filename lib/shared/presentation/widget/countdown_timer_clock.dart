import 'dart:async';

import 'package:app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [CountdownTimerClock] : widget for countdown timer
/// It takes [timeInSeconds] and [onFinished] callback
/// Countdown timer runs for [timeInSeconds] seconds and stops when time is up
/// [onFinished] callback is called when time is up
class CountdownTimerClock extends StatefulWidget {
  final int timeInSeconds;
  final void Function() onFinished;

  const CountdownTimerClock(
      {super.key, required this.timeInSeconds, required this.onFinished});

  @override
  State<CountdownTimerClock> createState() => _CountdownTimerClockState();
}

class _CountdownTimerClockState extends State<CountdownTimerClock> {
  late final Timer _timer;
  int timeElapsed = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        // cancel timer if time is exceeded
        if (timeElapsed >= widget.timeInSeconds) {
          t.cancel();
          widget.onFinished.call();
          return;
        }

        // increment timer
        if (context.mounted) {
          setState(() {
            timeElapsed++;
          });
        }
      },
    );
  }

  @override
  void deactivate() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int remainingSeconds = widget.timeInSeconds - timeElapsed;

    //final int hours = remainingSeconds ~/ 3600;
    final int minutes = (remainingSeconds % 3600) ~/ 60;
    final int seconds = (remainingSeconds % 3600) % 60;

    final String timeFormat =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Text(
      timeFormat,
      style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          height: 1.2,
          color: remainingSeconds > 10
              ? AppColors.colorAppGreen
              : AppColors.colorAppRed),
    );
  }
}
