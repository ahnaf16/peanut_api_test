import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';
import 'package:toastification/toastification.dart';

extension TestWiEx on Text {
  Widget required([bool isRequired = true]) {
    return Builder(
      builder: (context) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(text: data, style: style),
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: (style ?? context.text.bodyMedium)?.copyWith(color: context.colors.error),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget get fit => FittedBox(child: this);

  Widget copyable([bool copyOnTap = false]) => clickable(
    onTap: copyOnTap ? () => Copier.copy(data) : null,
    onLongPress: !copyOnTap ? () => Copier.copy(data) : null,
  );
}

extension WidgetEx on Widget {
  Widget clickable({void Function()? onTap, void Function()? onLongPress}) {
    return GestureDetector(onTap: onTap, onLongPress: onLongPress, child: this);
  }

  Widget conditionalExpanded(bool condition, [int flex = 1]) => condition ? Expanded(flex: flex, child: this) : this;
  Widget conditionalFlexible(bool condition, [int flex = 1]) => condition ? Flexible(flex: flex, child: this) : this;

  Widget debugView() {
    if (kReleaseMode) return this;
    final colors = [...Colors.accents, ...Colors.primaries];
    return ColoredBox(color: colors[Random().nextInt(colors.length)], child: this);
  }

  Widget withSF([String? title]) => Scaffold(
    body: this,
    appBar: AppBar(title: Text(title ?? '')),
  );

  SliverPadding toSliver({EdgeInsetsGeometry? padding}) => SliverPadding(
    padding: padding ?? EdgeInsets.zero,
    sliver: SliverToBoxAdapter(child: this),
  );
}

extension SeparatedIterableEx on Iterable<Widget> {
  List<Widget> separatedBy(Widget separator, {bool includeLast = false}) {
    final result = <Widget>[];
    final iterator = this.iterator;

    if (iterator.moveNext()) {
      result.add(iterator.current);
      while (iterator.moveNext()) {
        result
          ..add(separator)
          ..add(iterator.current);
      }

      if (includeLast) {
        result.add(separator);
      }
    }

    return result;
  }

  List<Widget> gapBy(double gap, {bool includeLast = false}) => separatedBy(Gap(gap), includeLast: includeLast);
}

extension ColorEX on Color {
  Color op(double opacity) => withValues(alpha: opacity);
  Color get op1 => op(.1);
  Color get op2 => op(.2);
  Color get op3 => op(.3);
  Color get op4 => op(.4);
  Color get op5 => op(.5);
  Color get op6 => op(.6);
  Color get op7 => op(.7);
  Color get op8 => op(.8);
  Color get op9 => op(.9);

  MaterialColor get toMat => toMaterialColor;
  Color get matDot => toMat.shade50;
  Color get mat1 => toMat.shade100;
  Color get mat2 => toMat.shade200;
  Color get mat3 => toMat.shade300;
  Color get mat4 => toMat.shade400;
  Color get mat5 => toMat.shade500;
  Color get mat6 => toMat.shade600;
  Color get mat7 => toMat.shade700;
  Color get mat8 => toMat.shade800;
  Color get mat9 => toMat.shade900;

  ColorFilter toFilter() => ColorFilter.mode(this, BlendMode.srcIn);
}
