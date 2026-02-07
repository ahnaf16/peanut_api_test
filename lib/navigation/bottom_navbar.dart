import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';

class BottomNavbar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isVertical; // Added this

  final double height;
  final Duration animationDuration;

  const BottomNavbar({
    super.key,
    required this.icons,
    required this.labels,
    required this.currentIndex,
    required this.onTap,
    this.isVertical = false,
    this.height = kBottomNavigationBarHeight,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : assert(icons.length == labels.length, 'Icons and Labels must be the same length');

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.surfaceContainerHighest;
    final sliderColor = context.colors.onPrimary;
    final activeColor = context.colors.primary;
    final inactiveColor = context.colors.onSurface;

    final margin = isVertical
        ? Pads.sym(1, 20).copyWith(left: context.padding.bottom + 4)
        : Pads.sym(16).copyWith(bottom: context.padding.bottom + 10);

    final List<Widget> navItems = List.generate(icons.length, (index) {
      final isSelected = currentIndex == index;
      return GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: DecoContainer.animated(
          duration: animationDuration,
          padding: isVertical ? Pads.sym(8, 20) : Pads.sym(30, 8),
          color: isSelected ? sliderColor : backgroundColor,
          borderRadius: 999,
          child: Icon(icons[index], size: 20, color: isSelected ? activeColor : inactiveColor),
        ),
      );
    });

    return DecoContainer(
      color: backgroundColor,
      borderRadius: 999,
      height: isVertical ? double.infinity : height,
      width: isVertical ? height : null,
      margin: margin,
      padding: isVertical ? const EdgeInsets.symmetric(vertical: 8) : const EdgeInsets.symmetric(horizontal: 8),
      child: isVertical
          ? Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: navItems)
          : Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: navItems),
    );
  }
}
