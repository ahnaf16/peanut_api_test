import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_wagens/main.export.dart';

abstract final class KAppTheme {
  static ColorScheme colors(bool isDark) => isDark ? darkColorScheme : lightColorScheme;

  static ThemeData get _light {
    return FlexThemeData.light(
      colorScheme: lightColorScheme,
      extensions: [XColors.light],
      scaffoldBackground: lightColorScheme.surface,
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: .outline,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
        defaultRadius: 10,
      ),

      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    );
  }

  static ThemeData get _dark => FlexThemeData.dark(
    colorScheme: darkColorScheme,
    extensions: [XColors.dark],
    scaffoldBackground: darkColorScheme.surface,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: .outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      defaultRadius: 10,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  static ThemeData appTheme(bool isDark) {
    final theme = isDark ? _dark : _light;

    return theme.copyWith(
      textTheme: textTheme(isDark),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: inputFill(isDark),
        filled: true,
        hintStyle: textTheme(isDark).bodyMedium!.textColor(colors(isDark).outline),
        border: inputBorder(),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(focus: true),
        errorBorder: inputBorder(error: true),
      ),
      appBarTheme: AppBarTheme(centerTitle: true, titleTextStyle: textTheme(isDark).bodyLarge?.semiBold),
    );
  }

  static Color inputFill(bool isDark) => isDark ? const Color(0xFF111827) : const Color(0xFFFFFFFF);

  static OutlineInputBorder inputBorder({bool focus = false, bool error = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colors(false).outlineVariant),
    );
  }

  static const font = GoogleFonts.inter;

  static TextTheme textTheme(bool isDark) {
    final ts = AppTextStyle.textTheme.merge(isDark ? _dark.textTheme : _light.textTheme);

    final tt = TextTheme(
      displayLarge: font(textStyle: ts.displayLarge),
      displayMedium: font(textStyle: ts.displayMedium),
      displaySmall: font(textStyle: ts.displaySmall),
      headlineLarge: font(textStyle: ts.headlineLarge),
      headlineMedium: font(textStyle: ts.headlineMedium),
      headlineSmall: font(textStyle: ts.headlineSmall),
      titleLarge: font(textStyle: ts.titleLarge),
      titleMedium: font(textStyle: ts.titleMedium),
      titleSmall: font(textStyle: ts.titleSmall),
      bodyLarge: font(textStyle: ts.bodyLarge),
      bodyMedium: font(textStyle: ts.bodyMedium),
      bodySmall: font(textStyle: ts.bodySmall),
      labelLarge: font(textStyle: ts.labelLarge),
      labelMedium: font(textStyle: ts.labelMedium),
      labelSmall: font(textStyle: ts.labelSmall),
    );

    return tt;
  }
}
