import 'package:flutter/material.dart';

class SmoothExpandableWidget extends StatefulWidget {
  /// The main content builder that is always visible.
  /// Provides the [fn] toggle function to be used in an InkWell or Button.
  final Widget Function(BuildContext context, bool isExpanded, void Function() toggle) builder;

  /// The items to show when expanded.
  /// Returns a list of widgets that will be placed in a Column.
  final List<Widget> Function(BuildContext context, void Function() toggle) expandedItemBuilder;
  final double spacing;
  final Duration duration;
  final Curve curve;

  const SmoothExpandableWidget({
    super.key,
    required this.builder,
    required this.expandedItemBuilder,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.spacing = 0,
  });

  @override
  State<SmoothExpandableWidget> createState() => _SmoothExpandableWidgetState();
}

class _SmoothExpandableWidgetState extends State<SmoothExpandableWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: widget.curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: widget.spacing,
      children: [
        widget.builder(context, _isExpanded, _toggleExpansion),

        ClipRect(
          child: AnimatedBuilder(
            animation: _controller.view,
            builder: (context, child) {
              return SizeTransition(sizeFactor: _heightFactor, axisAlignment: -1.0, child: child);
            },
            child: Column(spacing: widget.spacing, children: widget.expandedItemBuilder(context, _toggleExpansion)),
          ),
        ),
      ],
    );
  }
}
