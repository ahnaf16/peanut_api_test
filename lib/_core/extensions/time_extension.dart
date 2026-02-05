import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as ta;

extension DateTimeEx on DateTime {
  String formatDate([String pattern = 'dd-MM-yyyy']) {
    return DateFormat(pattern).format(this);
  }

  String ago() {
    return ta.format(this);
  }

  String fd() {
    final pattern = 'dd-MM-yyyy hh:mm a${isUtc ? ' u' : ''}';
    if (kDebugMode) return DateFormat(pattern).format(this);
    return formatDate();
  }

  TimeOfDay toTimeOfDay() => TimeOfDay.fromDateTime(this);
  DateTime fromTimeOfDay(TimeOfDay time) =>
      DateTime(year, month, day, time.hour, time.minute, second, millisecond, microsecond);

  DateTime get justDate => DateTime(year, month, day);
}

extension DurationEx on Duration {
  double progressOf(Duration? total) {
    if (total == null) return 0.0;
    if (total.inMilliseconds == 0) return 0.0;
    return inMilliseconds.clamp(0, total.inMilliseconds) / total.inMilliseconds;
  }

  Duration remaining(Duration total) {
    return (total - this);
  }
}
