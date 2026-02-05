import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';

class SlidingIconNavbar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final int currentIndex;
  final ValueChanged<int> onTap;

  // New parameters for the overlay logic
  final int? showOverlayAt;
  final WidgetBuilder? overlayBuilder;

  final double height;
  final Duration animationDuration;

  const SlidingIconNavbar({
    super.key,
    required this.icons,
    required this.labels,
    required this.currentIndex,
    required this.onTap,
    this.showOverlayAt,
    this.overlayBuilder,
    this.height = kBottomNavigationBarHeight,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : assert(icons.length == labels.length, 'Icons and Labels must be the same length');

  @override
  Widget build(BuildContext context) {
    final double alignmentX = -1.0 + (currentIndex * (2 / (icons.length - 1)));

    final backgroundColor = context.colors.surfaceContainer;
    final sliderColor = context.colors.onPrimary;
    final activeColor = context.colors.primary;
    final inactiveColor = context.colors.onSurface;

    return DecoContainer(
      color: backgroundColor,
      borderRadius: 24,
      height: kBottomNavigationBarHeight,
      margin: Pads.sym(8, 10).copyWith(bottom: context.padding.bottom + 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          // 1. THE SLIDING BACKGROUND
          AnimatedAlign(
            duration: animationDuration,
            curve: Curves.easeInOutCubic,
            alignment: Alignment(alignmentX, 0),
            child: FractionallySizedBox(
              widthFactor: 1 / (icons.length - 1.5),
              child: Container(
                height: height * 0.70,
                decoration: BoxDecoration(
                  color: sliderColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.black.op(0.05), blurRadius: 10)],
                ),
              ),
            ),
          ),

          // 2. THE ICONS & LABELS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(icons.length, (index) {
              final isSelected = currentIndex == index;

              return GestureDetector(
                onTap: () {
                  onTap(index);
                  if (index == showOverlayAt && overlayBuilder != null) {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => overlayBuilder!(context),
                    );
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Center(
                  child: AnimatedContainer(
                    duration: animationDuration,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icons[index], color: isSelected ? activeColor : inactiveColor),
                        ClipRect(
                          child: AnimatedSize(
                            duration: animationDuration,
                            curve: Curves.easeInOut,
                            child: isSelected
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      labels[index],
                                      style: context.text.bodyMedium!.textColor(
                                        isSelected ? activeColor : inactiveColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
