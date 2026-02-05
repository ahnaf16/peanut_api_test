import 'dart:math';

import 'package:post_wagens/main.export.dart';

class Parser {
  const Parser._();

  static int? toInt(dynamic value) {
    try {
      if (value == null) return null;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    } catch (e) {
      return null;
    }
  }

  static double? toDouble(dynamic value) {
    try {
      if (value == null) return null;
      double? parsedValue;

      if (value is num) {
        parsedValue = value.toDouble();
      } else if (value is String) {
        parsedValue = double.tryParse(value);
      }

      return parsedValue;
    } catch (e) {
      return null;
    }
  }

  static num? toNum(dynamic value, [bool format = true]) {
    try {
      if (value == null) return null;
      num? parsedValue;

      if (value is num) {
        parsedValue = value.toDouble();
      } else if (value is String) {
        parsedValue = num.tryParse(value);
      }
      if (parsedValue != null && format) return formatNumber(parsedValue);

      return parsedValue;
    } catch (e) {
      return null;
    }
  }

  static num formatNumber(num value) {
    if (value is int || value == value.roundToDouble()) {
      return value.toInt();
    } else {
      return double.parse(value.toStringAsFixed(2));
    }
  }

  static bool? toBool(dynamic value) {
    try {
      if (value is bool) return value;
      if (value == null) return null;

      if (value == '1' || value == 1) return true;
      if (value == '0' || value == 0) return false;
      if (value is String) return bool.tryParse(value);

      return null;
    } catch (e) {
      return null;
    }
  }

  static QMap toMapped(dynamic data) {
    try {
      if (data is QMap) return data;
      if (data is Map) return QMap.from(data.toStringKey());
      if (data is List) return data.asMap().toStringKey();
      return {};
    } catch (e) {
      return {};
    }
  }

  static List intoList(dynamic data) {
    try {
      if (data is List) return data;
      if (data is Map) return data.values.toList();
      return [];
    } catch (e) {
      return [];
    }
  }

  static DateTime? tryDate(dynamic date) {
    try {
      if (date is DateTime) return date;
      if (date is String) return DateTime.tryParse(date);

      return null;
    } catch (e) {
      return null;
    }
  }

  static String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  static String? forceStringOrNull(dynamic value) {
    final it = value?.toString();
    if (it == null) return null;

    return it.trim().isEmpty ? null : it;
  }

  static String? ifStringOrNull(dynamic value) {
    if (value case final String s) return s.trim().isEmpty ? null : s;
    return null;
  }
}
