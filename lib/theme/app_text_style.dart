import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static const textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  static const displayLarge = TextStyle(fontSize: 57, height: 1.12, fontWeight: .w400, letterSpacing: -0.25);
  static const displayLargeEmp = TextStyle(fontSize: 57, height: 1.12, fontWeight: .w500, letterSpacing: -0.25);

  static const displayMedium = TextStyle(fontSize: 45, height: 1.16, fontWeight: .w400);
  static const displayMediumEmp = TextStyle(fontSize: 45, height: 1.16, fontWeight: .w500);

  static const displaySmall = TextStyle(fontSize: 36, height: 1.22, fontWeight: .w400);
  static const displaySmallEmp = TextStyle(fontSize: 36, height: 1.22, fontWeight: .w500);

  static const headlineLarge = TextStyle(fontSize: 32, height: 1.25, fontWeight: .w400);
  static const headlineLargeEmp = TextStyle(fontSize: 32, height: 1.25, fontWeight: .w500);

  static const headlineMedium = TextStyle(fontSize: 28, height: 1.29, fontWeight: .w400);
  static const headlineMediumEmp = TextStyle(fontSize: 28, height: 1.29, fontWeight: .w500);

  static const headlineSmall = TextStyle(fontSize: 24, height: 1.33, fontWeight: .w400);
  static const headlineSmallEmp = TextStyle(fontSize: 24, height: 1.33, fontWeight: .w500);

  static const titleLarge = TextStyle(fontSize: 22, height: 1.27, fontWeight: .w400);
  static const titleLargeEmp = TextStyle(fontSize: 22, height: 1.27, fontWeight: .w500);

  static const titleMedium = TextStyle(fontSize: 16, height: 1.5, fontWeight: .w500, letterSpacing: 0.15);
  static const titleMediumEmp = TextStyle(fontSize: 16, height: 1.5, fontWeight: .w600, letterSpacing: 0.15);

  static const titleSmall = TextStyle(fontSize: 14, height: 1.43, fontWeight: .w500, letterSpacing: 0.1);
  static const titleSmallEmp = TextStyle(fontSize: 14, height: 1.43, fontWeight: .w600, letterSpacing: 0.1);

  static const labelLarge = TextStyle(fontSize: 14, height: 1.43, fontWeight: .w500, letterSpacing: 0.1);
  static const labelLargeEmp = TextStyle(fontSize: 14, height: 1.43, fontWeight: .w600, letterSpacing: 0.1);

  static const labelMedium = TextStyle(fontSize: 12, height: 1.33, fontWeight: .w500, letterSpacing: 0.5);
  static const labelMediumEmp = TextStyle(fontSize: 12, height: 1.33, fontWeight: .w600, letterSpacing: 0.5);

  static const labelSmall = TextStyle(fontSize: 11, height: 1.45, fontWeight: .w500, letterSpacing: 0.5);
  static const labelSmallEmp = TextStyle(fontSize: 11, height: 1.45, fontWeight: .w600, letterSpacing: 0.5);

  static const bodyLarge = TextStyle(fontSize: 16, height: 1.5, fontWeight: .w400, letterSpacing: 0.5);
  static const bodyLargeEmp = TextStyle(fontSize: 16, height: 1.5, fontWeight: .w500, letterSpacing: 0.5);

  static const bodyMedium = TextStyle(fontSize: 14, height: 1.43, fontWeight: .w400, letterSpacing: 0.25);
  static const bodyMediumEmp = TextStyle(fontSize: 14, height: 1.43, fontWeight: .w500, letterSpacing: 0.25);

  static const bodySmall = TextStyle(fontSize: 12, height: 1.33, fontWeight: .w400, letterSpacing: 0.4);
  static const bodySmallEmp = TextStyle(fontSize: 12, height: 1.33, fontWeight: .w500, letterSpacing: 0.4);
}
