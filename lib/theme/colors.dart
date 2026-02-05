import 'package:flutter/material.dart';

ColorScheme get lightColorScheme {
  return const ColorScheme(
    brightness: Brightness.light,

    // ─── PRIMARY ─────────────────────────────────────────────
    primary: Color(0xFF1F5FBF),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE5F0FF),
    onPrimaryContainer: Color(0xFF0C2E5E),

    primaryFixed: Color(0xFF1F5FBF),
    primaryFixedDim: Color(0xFF9DB9F0),
    onPrimaryFixed: Color(0xFFFFFFFF),
    onPrimaryFixedVariant: Color(0xFF0C2E5E),

    // ─── SECONDARY ───────────────────────────────────────────
    secondary: Color(0xFF5F6C7B),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE5E9F0),
    onSecondaryContainer: Color(0xFF2A3340),

    secondaryFixed: Color(0xFF5F6C7B),
    secondaryFixedDim: Color(0xFFB8C0CC),
    onSecondaryFixed: Color(0xFFFFFFFF),
    onSecondaryFixedVariant: Color(0xFF2A3340),

    // ─── TERTIARY (used as neutral accent) ───────────────────
    tertiary: Color(0xFFE5E9F0),
    onTertiary: Color(0xFF2A3340),
    tertiaryContainer: Color(0xFFF0F3F8),
    onTertiaryContainer: Color(0xFF2A3340),

    tertiaryFixed: Color(0xFFE5E9F0),
    tertiaryFixedDim: Color(0xFFD6DBE4),
    onTertiaryFixed: Color(0xFF2A3340),
    onTertiaryFixedVariant: Color(0xFF445160),

    // ─── ERROR ───────────────────────────────────────────────
    error: Color(0xFFEE4F4F),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFE3E3),
    onErrorContainer: Color(0xFF7A1F1F),

    // ─── SURFACE ─────────────────────────────────────────────
    surface: Color(0xFFF5F7FA),
    onSurface: Color(0xFF111827),

    surfaceDim: Color(0xFFE6E8EC),
    surfaceBright: Color(0xFFFFFFFF),

    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF8FAFC),
    surfaceContainer: Color(0xFFF1F3F6),
    surfaceContainerHigh: Color(0xFFE9ECF1),
    surfaceContainerHighest: Color(0xFFE2E6ED),

    onSurfaceVariant: Color(0xFF4B5563),

    // ─── OUTLINE / SHADOW ────────────────────────────────────
    outline: Color(0xFFACACAC),
    outlineVariant: Color(0xFFE5E9F0),

    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    // ─── INVERSE ─────────────────────────────────────────────
    inverseSurface: Color(0xFF1F2937),
    onInverseSurface: Color(0xFFF9FAFB),
    inversePrimary: Color(0xFFB6D4FF),

    // ─── MISC ────────────────────────────────────────────────
    surfaceTint: Color(0xFF1F5FBF),
  );
}

ColorScheme get darkColorScheme {
  return const ColorScheme(
    brightness: Brightness.dark,

    // ─── PRIMARY ─────────────────────────────────────────────
    primary: Color(0xFFB6D4FF),
    onPrimary: Color(0xFF0C2E5E),
    primaryContainer: Color(0xFF1A3F7A),
    onPrimaryContainer: Color(0xFFDCE9FF),

    primaryFixed: Color(0xFFB6D4FF),
    primaryFixedDim: Color(0xFF8FB3F4),
    onPrimaryFixed: Color(0xFF0C2E5E),
    onPrimaryFixedVariant: Color(0xFF163B73),

    // ─── SECONDARY ───────────────────────────────────────────
    secondary: Color(0xFFB8C0CC),
    onSecondary: Color(0xFF2A3340),
    secondaryContainer: Color(0xFF3A4350),
    onSecondaryContainer: Color(0xFFE5E9F0),

    secondaryFixed: Color(0xFFB8C0CC),
    secondaryFixedDim: Color(0xFF9AA3AF),
    onSecondaryFixed: Color(0xFF1F2937),
    onSecondaryFixedVariant: Color(0xFF374151),

    // ─── TERTIARY ────────────────────────────────────────────
    tertiary: Color(0xFFD6DBE4),
    onTertiary: Color(0xFF1F2937),
    tertiaryContainer: Color(0xFF2F3642),
    onTertiaryContainer: Color(0xFFE5E9F0),

    tertiaryFixed: Color(0xFFD6DBE4),
    tertiaryFixedDim: Color(0xFFBFC6D1),
    onTertiaryFixed: Color(0xFF1F2937),
    onTertiaryFixedVariant: Color(0xFF374151),

    // ─── ERROR ───────────────────────────────────────────────
    error: Color(0xFFFF8A8A),
    onError: Color(0xFF5C1414),
    errorContainer: Color(0xFF7A1F1F),
    onErrorContainer: Color(0xFFFFDADA),

    // ─── SURFACE ─────────────────────────────────────────────
    surface: Color(0xFF0F172A),
    onSurface: Color(0xFFE5E7EB),

    surfaceDim: Color(0xFF0B1220),
    surfaceBright: Color(0xFF1A2234),

    surfaceContainerLowest: Color(0xFF0A0F1C),
    surfaceContainerLow: Color(0xFF111827),
    surfaceContainer: Color(0xFF161E2E),
    surfaceContainerHigh: Color(0xFF1C2536),
    surfaceContainerHighest: Color(0xFF243045),

    onSurfaceVariant: Color(0xFF9CA3AF),

    // ─── OUTLINE / SHADOW ────────────────────────────────────
    outline: Color(0xFF6B7280),
    outlineVariant: Color(0xFF374151),

    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    // ─── INVERSE ─────────────────────────────────────────────
    inverseSurface: Color(0xFFE5E7EB),
    onInverseSurface: Color(0xFF111827),
    inversePrimary: Color(0xFF1F5FBF),

    // ─── MISC ────────────────────────────────────────────────
    surfaceTint: Color(0xFFB6D4FF),
  );
}
