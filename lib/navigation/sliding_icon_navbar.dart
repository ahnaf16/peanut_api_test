import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';

class SlidingIconNavbar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final int currentIndex;
  final ValueChanged<int> onTap;

  final double height;
  final Duration animationDuration;

  const SlidingIconNavbar({
    super.key,
    required this.icons,
    required this.labels,
    required this.currentIndex,
    required this.onTap,
    this.height = kBottomNavigationBarHeight,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : assert(icons.length == labels.length, 'Icons and Labels must be the same length');

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.surfaceContainerHighest;
    final sliderColor = context.colors.onPrimary;
    final activeColor = context.colors.primary;
    final inactiveColor = context.colors.onSurface;

    return DecoContainer(
      color: backgroundColor,
      borderRadius: 999,
      height: kBottomNavigationBarHeight,
      margin: Pads.sym(16).copyWith(bottom: context.padding.bottom + 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () {
              onTap(index);
            },
            behavior: .opaque,
            child: DecoContainer.animated(
              duration: animationDuration,
              padding: Pads.sym(30, 8),
              color: isSelected ? sliderColor : backgroundColor,
              borderRadius: 999,
              child: Icon(icons[index], size: 20, color: isSelected ? activeColor : inactiveColor),
            ),
          );
        }),
      ),
    );
  }
}
