import 'dart:async';

import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';

final toaster = ToastStream.instance;

class ToastStream {
  ToastStream._();
  static final ToastStream instance = ToastStream._();

  final _controller = StreamController<ToastEvent>.broadcast();

  Stream<ToastEvent> get stream => _controller.stream;

  void showSuccess(
    String title, {
    String? message,
    String? actionText,
    IconData? actionIcon,
    void Function()? actionTap,
    Duration duration = const Duration(seconds: 3),
  }) {
    _controller.add(
      ToastEvent.success(
        title: title,
        message: message,
        actionText: actionText,
        actionIcon: actionIcon,
        actionTap: actionTap,
        duration: duration,
      ),
    );
  }

  void showError(
    String title, {
    String? message,
    String? actionText,
    IconData? actionIcon,
    void Function()? actionTap,
    Duration duration = const Duration(seconds: 4),
  }) {
    _controller.add(
      ToastEvent.error(
        title: title,
        message: message,
        actionText: actionText,
        actionIcon: actionIcon,
        actionTap: actionTap,
        duration: duration,
      ),
    );
  }

  void showInfo(
    String title, {
    String? message,
    String? actionText,
    IconData? actionIcon,
    void Function()? actionTap,
    Duration duration = const Duration(seconds: 3),
  }) {
    _controller.add(
      ToastEvent.info(
        title: title,
        message: message,
        actionText: actionText,
        actionIcon: actionIcon,
        actionTap: actionTap,
        duration: duration,
      ),
    );
  }
}

class ToastOverlay extends StatefulWidget {
  final Widget child;
  const ToastOverlay({super.key, required this.child});

  static ToastOverlayState of(BuildContext context) => context.findAncestorStateOfType<ToastOverlayState>()!;

  @override
  State<ToastOverlay> createState() => ToastOverlayState();
}

class ToastOverlayState extends State<ToastOverlay> with SingleTickerProviderStateMixin {
  StreamSubscription? _sub;
  OverlayEntry? _entry;

  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic));

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut, reverseCurve: Curves.easeIn));

    _sub = ToastStream.instance.stream.listen(_show);
  }

  void _show(ToastEvent event) async {
    _entry?.remove();
    _controller.reset();

    _entry = OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        right: 0,
        bottom: context.padding.bottom + 16,
        child: SafeArea(
          child: SlideTransition(
            position: _slide,
            child: FadeTransition(
              opacity: _fade,
              child: Center(
                child: AppToast(
                  event: event,
                  closer: () {
                    _controller.reverse().then((_) {
                      _entry?.remove();
                      _entry = null;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final overlay = Overlay.of(context, rootOverlay: true);

    overlay.insert(_entry!);

    await _controller.forward();

    await Future.delayed(event.duration);

    await _controller.reverse();

    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _sub?.cancel();
    _controller.dispose();
    _entry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
