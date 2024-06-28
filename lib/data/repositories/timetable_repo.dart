import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Timetable {
  final DateTime startDayTime;
  final DateTime endDayTime;
  final int interval;

  Timetable(
      {required this.startDayTime,
      required this.endDayTime,
      required this.interval});

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      startDayTime: DateTime.parse(json['startDayTime']),
      endDayTime: DateTime.parse(json['endDayTime']),
      interval: json['interval'],
    );
  }

  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return {
      'startDayTime': formatter.format(startDayTime),
      'endDayTime': formatter.format(endDayTime),
      'interval': interval,
    };
  }
}

extension DateTimeExtension on DateTime {
  DateTime setTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
