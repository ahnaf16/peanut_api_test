export 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';

class SegmentedTabbar extends StatelessWidget {
  const SegmentedTabbar({super.key, required this.tabs, this.backgroundColor, this.foregroundColor, this.controller});
  final List<SegmentTab> tabs;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    return SegmentedTabControl(
      selectedTabTextColor: context.colors.onInverseSurface,
      textStyle: context.text.bodyLarge,
      indicatorPadding: const EdgeInsets.all(3),
      tabTextColor: context.colors.onSurface,
      indicatorDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: foregroundColor ?? context.colors.onPrimary,
      ),
      barDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: backgroundColor ?? context.colors.surfaceContainerHighest,
      ),
      controller: controller,
      tabs: tabs,
    );
  }
}
