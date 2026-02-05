import 'package:flutter/material.dart';

class Rotator extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isRotating;

  const Rotator({super.key, required this.child, this.duration = const Duration(seconds: 2), this.isRotating = true});

  @override
  State<Rotator> createState() => _RotatorState();
}

class _RotatorState extends State<Rotator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    if (widget.isRotating) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant Rotator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
      if (widget.isRotating) _controller.repeat();
    }

    if (widget.isRotating != oldWidget.isRotating) {
      if (widget.isRotating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child: widget.child);
  }
}
