import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';

extension TextStyleExtensions on TextStyle {
  // Weights
  TextStyle get thin => weight(FontWeight.w100);
  TextStyle get extraLight => weight(FontWeight.w200);
  TextStyle get light => weight(FontWeight.w300);
  TextStyle get regular => weight(FontWeight.normal);
  TextStyle get medium => weight(FontWeight.w500);
  TextStyle get semiBold => weight(FontWeight.w600);
  TextStyle get bold => weight(FontWeight.w700);
  TextStyle get extraBold => weight(FontWeight.w800);
  TextStyle get black => weight(FontWeight.w900);

  /// Shortcut for italic
  TextStyle get italic => style(FontStyle.italic);

  /// Shortcut for underline
  TextStyle get underline => textDecoration(TextDecoration.underline);

  /// Shortcut for lineThrough
  TextStyle get lineThrough => textDecoration(TextDecoration.lineThrough);

  /// Shortcut for overline
  TextStyle get overline => textDecoration(TextDecoration.overline);

  /// Shortcut for color
  TextStyle textColor(Color? v) => copyWithG(color: v);
  TextStyle get primary => copyWithG(color: Ctx.tryContext?.colors.primary);
  TextStyle get onPrimary => copyWithG(color: Ctx.tryContext?.colors.onPrimary);
  TextStyle get secondary => copyWithG(color: Ctx.tryContext?.colors.secondary);
  TextStyle get onSecondary => copyWithG(color: Ctx.tryContext?.colors.onSecondary);
  TextStyle get outline => copyWithG(color: Ctx.tryContext?.colors.outline);

  TextStyle op(double v) => copyWithG(color: color?.op(v));

  /// Shortcut for backgroundColor
  TextStyle textBackgroundColor(Color v) => copyWithG(backgroundColor: v);

  /// Shortcut for fontSize
  TextStyle size(double v) => copyWithG(fontSize: v);

  /// Scales fontSize up or down
  TextStyle scale(double v) => copyWithG(fontSize: (fontSize ?? 1) * v);

  /// Shortcut for fontWeight
  TextStyle weight(FontWeight v) => copyWithG(fontWeight: v);

  /// Shortcut for FontStyle
  TextStyle style(FontStyle v) => copyWithG(fontStyle: v);

  /// Shortcut for letterSpacing
  TextStyle letterSpace(double v) => copyWithG(letterSpacing: v);

  /// Shortcut for wordSpacing
  TextStyle wordSpace(double v) => copyWithG(wordSpacing: v);

  /// Shortcut for textBaseline
  TextStyle baseline(TextBaseline v) => copyWithG(textBaseline: v);

  /// Shortcut for height
  TextStyle textHeight(double v) => copyWithG(height: v);

  /// Shortcut for locale
  TextStyle textLocale(Locale v) => copyWithG(locale: v);

  /// Shortcut for foreground
  TextStyle textForeground(Paint v) => copyWithG(foreground: v);

  /// Shortcut for background
  TextStyle textBackground(Paint v) => copyWithG(background: v);

  /// Shortcut for shadows
  TextStyle textShadows(List<Shadow> v) => copyWithG(shadows: v);

  /// Shortcut for fontFeatures
  TextStyle textFeatures(List<FontFeature> v) => copyWithG(fontFeatures: v);

  /// Shortcut for decoration
  TextStyle textDecoration(TextDecoration v, {Color? color, TextDecorationStyle? style, double? thickness}) =>
      copyWithG(decoration: v, decorationColor: color, decorationStyle: style, decorationThickness: thickness);

  TextStyle copyWithG({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    String? newDebugLabel;
    assert(() {
      if (debugLabel != null) {
        newDebugLabel = debugLabel;
      } else if (this.debugLabel != null) {
        newDebugLabel = '(${this.debugLabel}).copyWith';
      }
      return true;
    }());

    return KAppTheme.font(
      color: this.foreground == null && foreground == null ? color ?? this.color : null,
      backgroundColor: this.background == null && background == null ? backgroundColor ?? this.backgroundColor : null,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
    ).copyWith(
      inherit: inherit ?? this.inherit,
      leadingDistribution: leadingDistribution ?? this.leadingDistribution,
      fontVariations: fontVariations ?? this.fontVariations,
      debugLabel: newDebugLabel,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      package: package,
      overflow: overflow ?? this.overflow,
    );
  }
}
