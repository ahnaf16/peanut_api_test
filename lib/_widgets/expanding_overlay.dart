import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';

class ExpandingOverlay extends StatefulWidget {
  const ExpandingOverlay({
    super.key,
    required this.header,
    this.headerBuilder,
    required this.children,
    this.overlayBuilder,
    this.bodyMaxHeight = 200,
    this.bodyWidth,
    this.animationDuration = const Duration(milliseconds: 300),
    this.childrenGap = Insets.med,
    this.headerPadding,
    this.useDivider = false,
    this.borderRadius,
    this.followerAnchor,
    this.targetAnchor,
  });

  final Widget header;
  final Widget Function(Widget child, bool expanded)? headerBuilder;
  final List<Widget> Function(Function() closer) children;
  final Widget Function(BuildContext context, Widget child)? overlayBuilder;
  final double bodyMaxHeight;
  final double? bodyWidth;
  final Duration animationDuration;
  final double childrenGap;
  final EdgeInsetsGeometry? headerPadding;
  final bool useDivider;
  final BorderRadiusGeometry? borderRadius;
  final Alignment? followerAnchor;
  final Alignment? targetAnchor;

  @override
  State<ExpandingOverlay> createState() => _ExpandingOverlayState();
}

class _ExpandingOverlayState extends State<ExpandingOverlay> with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Size _headerSize = Size.zero;
  bool _expanded = false;

  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _scale = Tween<double>(
      begin: 0.95,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  void _toggleOverlay() {
    setState(() => _expanded = !_expanded);

    if (_expanded) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
  }

  void _showOverlay() {
    final child = ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.bodyMaxHeight),
      child: SingleChildScrollView(
        child: Column(
          spacing: widget.childrenGap,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children(() {
            _hideOverlay();
            setState(() => _expanded = false);
          }),
        ),
      ),
    );
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: widget.bodyWidth ?? _headerSize.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            followerAnchor: widget.followerAnchor ?? Alignment.topLeft,
            targetAnchor: widget.targetAnchor ?? Alignment.topLeft,
            showWhenUnlinked: false,
            offset: Offset(0, _headerSize.height),
            child: FadeTransition(
              opacity: _opacity,
              child: ScaleTransition(
                scale: _scale,
                alignment: Alignment.topCenter,
                child: Material(
                  type: MaterialType.transparency,
                  borderRadius: widget.borderRadius ?? const BorderRadius.vertical(bottom: Radius.circular(16)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      if (widget.overlayBuilder != null)
                        widget.overlayBuilder!(context, child)
                      else
                        DecoContainer(
                          width: widget.bodyWidth ?? _headerSize.width,
                          padding: Pads.sym(16, 8),
                          borderRadius: 5,
                          borderColor: context.colors.outline,
                          borderWidth: 1,
                          color: context.colors.outlineVariant,
                          alignment: .centerLeft,
                          child: child,
                        ),

                      if (widget.useDivider)
                        Container(height: 1, width: context.width, color: context.colors.outlineVariant.op6),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward(from: 0); // animate in
  }

  void _hideOverlay() async {
    await _controller.reverse(); // play exit animation
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleOverlay,
        child: LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final renderBox = context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                _headerSize = renderBox.size;
              }
            });

            if (widget.headerBuilder != null) {
              return widget.headerBuilder!(widget.header, _expanded);
            }

            return DecoContainer(
              padding: Pads.sym(16),
              borderRadius: 5,
              height: 40,
              shadows: [BoxShadow(color: Colors.black.op(.15), blurRadius: 4)],
              color: context.colors.outlineVariant,
              alignment: .centerLeft,
              child: widget.header,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    _controller.dispose();
    super.dispose();
  }
}
