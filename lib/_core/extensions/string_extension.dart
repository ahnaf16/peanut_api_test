import 'package:flutter/material.dart';

extension StringEx on String {
  String showUntil(int end, [int start = 0]) {
    return length >= end ? '${substring(start, end)}...' : this;
  }

  String ifEmpty([String onEmpty = 'EMPTY']) {
    return isEmpty ? onEmpty : this;
  }

  bool get isValidEmail {
    final reg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return reg.hasMatch(this);
  }

  String get low => toLowerCase();
  String get up => toUpperCase();

  String decodeUri() => Uri.decodeFull(this);
  String encodeUri() => Uri.encodeFull(this);

  /// Tries to convert this String (hex color) into a Flutter Color.
  /// Returns null if conversion fails.
  Color? tryParseColor() {
    if (trim().isEmpty) return null;

    try {
      String hex = replaceAll('#', '').replaceAll('0x', '');

      hex = hex.padLeft(6, '0');
      hex = hex.padLeft(8, 'F');

      final value = int.parse('0x$hex');
      return Color(value);
    } catch (_) {
      return null;
    }
  }
}
