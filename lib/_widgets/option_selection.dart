import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';

class OptionSelector<T> extends StatefulWidget {
  const OptionSelector({
    super.key,
    required this.items,
    this.onChanged,
    this.initialValue,
    this.isRequired = false,
    this.equable,
    this.labelBuilder,
    this.hintText = 'Select an option',
    this.hintStyle,
    this.title,
    this.titleStyle,
    this.itemBuilder,
    this.headerBuilder,
    this.bodyMaxHeight = 300,
    this.bodyWidth,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 250),
    this.headerHeight,
    this.headerPadding,
    this.backgroundColor,
    this.prefixIcon,
    this.suffix,
  });

  final List<T> items;
  final ValueChanged<T>? onChanged;
  final T? initialValue;
  final bool isRequired;
  final bool Function(T item, T? selected)? equable;
  final String Function(T item)? labelBuilder;
  final String hintText;
  final TextStyle? hintStyle;
  final String? title;
  final TextStyle? titleStyle;
  final double? headerHeight;
  final Widget Function(BuildContext context, T item, bool isSelected)? itemBuilder;
  final Widget Function(BuildContext context, T? selectedItem, bool isExpanded)? headerBuilder;

  final double bodyMaxHeight;
  final double? bodyWidth;
  final BorderRadiusGeometry? borderRadius;
  final Duration animationDuration;
  final EdgeInsetsGeometry? headerPadding;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final Widget? suffix;

  @override
  State<OptionSelector<T>> createState() => _OptionSelectorState<T>();
}

class _OptionSelectorState<T> extends State<OptionSelector<T>> with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isExpanded = false;
  T? _selectedItem;

  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    _expandAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void didUpdateWidget(OptionSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _selectedItem = widget.initialValue;
    }
  }

  void _toggleOverlay() {
    if (_isExpanded) {
      _closeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _closeOverlay,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            width: widget.bodyWidth ?? size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, (widget.headerHeight ?? 55) + 4),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SizeTransition(
                  sizeFactor: _expandAnimation,
                  axisAlignment: -1,
                  child: Material(
                    color: widget.backgroundColor,
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
                    child: Container(
                      constraints: BoxConstraints(maxHeight: widget.bodyMaxHeight),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colors.outline.op5),
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        padding: Pads.all(4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: widget.items.map((item) {
                            final isSelected = widget.equable?.call(item, _selectedItem) ?? _selectedItem == item;
                            return GestureDetector(
                              onTap: () {
                                Haptic.selectionClick();
                                setState(() => _selectedItem = item);
                                widget.onChanged?.call(item);
                                _closeOverlay();
                              },
                              behavior: HitTestBehavior.opaque,
                              child:
                                  widget.itemBuilder?.call(context, item, isSelected) ??
                                  Container(
                                    width: double.infinity,
                                    padding: Pads.sym(12, 10),
                                    decoration: BoxDecoration(
                                      color: isSelected ? context.colors.onPrimary.op(.1) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      widget.labelBuilder?.call(item) ?? item.toString(),
                                      style: context.text.bodyMedium?.copyWithG(
                                        color: isSelected ? context.colors.onPrimary : context.colors.onSurface,
                                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
    setState(() => _isExpanded = true);
  }

  void _closeOverlay() async {
    if (!_isExpanded) return;
    await _controller.reverse();
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isExpanded = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(widget.title!, style: widget.titleStyle ?? context.text.labelLarge?.bold).required(widget.isRequired),
          const Gap(Insets.sm),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleOverlay,
            child: DecoContainer(
              height: widget.headerHeight ?? 55,
              padding: widget.headerPadding ?? Pads.sym(16, 8),
              borderRadius: 16.4,
              borderWidth: 1,
              borderColor: _isExpanded ? context.colors.primary : context.colors.outline.op3,
              color: widget.backgroundColor ?? context.theme.inputDecorationTheme.fillColor,
              child:
                  widget.headerBuilder?.call(context, _selectedItem, _isExpanded) ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: Insets.med,
                    children: [
                      if (widget.prefixIcon != null)
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 20, maxHeight: 20),
                          child: IconTheme(
                            data: IconThemeData(color: context.colors.outline),
                            child: FittedBox(child: widget.prefixIcon),
                          ),
                        ),
                      Expanded(
                        child: Text(
                          _selectedItem != null
                              ? (widget.labelBuilder?.call(_selectedItem as T) ?? _selectedItem.toString())
                              : widget.hintText,
                          style: context.text.bodyMedium?.copyWithG(
                            color: _selectedItem == null ? context.colors.outline : context.colors.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconTheme(
                        data: IconThemeData(color: _isExpanded ? context.colors.primary : context.colors.outline),
                        child: RotationTransition(
                          turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                          child: widget.suffix ?? const Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _controller.dispose();
    super.dispose();
  }
}
