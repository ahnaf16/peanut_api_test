import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size, this.strokeWidth, this.indicatorColor}) : _onPrimary = false;
  const LoadingIndicator.onPrimary({super.key, this.size, this.strokeWidth}) : _onPrimary = true, indicatorColor = null;

  final bool _onPrimary;
  final double? size;
  final double? strokeWidth;

  /// if not null, this will override the default color
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    final color = indicatorColor ?? (_onPrimary ? context.colors.onPrimary : context.colors.primary);
    if (context.isIos) return CupertinoActivityIndicator(color: color);

    return SizedBox.square(
      dimension: size ?? 20,
      child: CircularProgressIndicator(color: color, strokeWidth: 2),
    );
  }
}

enum LoadingStyle { start, end, replace, manual }

extension LoadingStyleX on LoadingStyle {
  Widget layout({required bool isLoading, required Widget content, required Widget loader}) {
    if (!isLoading) return content;

    return switch (this) {
      .manual => content,
      .replace => Stack(
        alignment: .center,
        children: [
          Visibility(
            visible: false,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: IgnorePointer(child: content),
          ),
          loader,
        ],
      ),
      .start => Row(mainAxisSize: .min, children: [loader, content]),
      .end => Row(mainAxisSize: .min, children: [content, loader]),
    };
  }
}

class LoadingBuilder extends HookWidget {
  const LoadingBuilder({super.key, required this.builder, this.style = .replace, this.loader});

  final Widget Function(BuildContext context, ValueNotifier<bool> loading) builder;
  final Widget? loader;
  final LoadingStyle style;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    return style.layout(
      isLoading: isLoading.value,
      content: builder(context, isLoading),
      loader: loader ?? const LoadingIndicator(),
    );
  }
}
