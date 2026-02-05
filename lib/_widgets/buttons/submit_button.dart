import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:post_wagens/main.export.dart';
import 'package:toastification/toastification.dart';

enum ButtonType { primary, danger, outlined }

class SubmitButton extends HookWidget {
  const SubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.enabled = true,
    this.shadedColor = false,
    this.expanded = false,
    this.dense = false,
    this.borderRadius,
    this.leading,
    this.trailing,
  });

  final String label;
  final Function(ValueNotifier<bool> loading)? onPressed;
  final ButtonType type;
  final bool enabled;

  /// uses lighter shades of colors
  ///
  /// Have No effect if [type] is [ButtonType.outlined]
  final bool shadedColor;
  final bool expanded;
  final bool dense;
  final double? borderRadius;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);

    Color getBackgroundColor() {
      if (!enabled && type != ButtonType.outlined) {
        return context.colors.outline.op7;
      }
      return switch (type) {
        ButtonType.primary => shadedColor ? context.colors.primary.toMaterialColor.shade100 : context.colors.primary,
        ButtonType.danger => context.colors.error,
        ButtonType.outlined => Colors.transparent,
      };
    }

    Color getContentColor() {
      if (!enabled) return context.colors.outline;
      return switch (type) {
        ButtonType.primary => shadedColor ? context.colors.primary : context.colors.onPrimary,
        ButtonType.danger => context.colors.onError,
        ButtonType.outlined => context.colors.primary,
      };
    }

    BorderSide getBorder() {
      if (type == ButtonType.outlined) {
        return BorderSide(
          color: enabled ? context.colors.primary : context.colors.outline.op7,
          strokeAlign: BorderSide.strokeAlignCenter,
        );
      }
      return BorderSide.none;
    }

    return InkWell(
      onTap: () async {
        try {
          if (!enabled || loading.value) return;

          onPressed?.call(loading);
        } catch (_) {
          loading.falsey();
          rethrow;
        }
      },
      child: AnimatedContainer(
        duration: 250.ms,
        padding: Pads.sym(dense ? 16 : 16, dense ? 6 : 8),
        height: dense ? 44 : 44,
        width: expanded ? context.width : null,
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10), side: getBorder()),
          color: getBackgroundColor(),
        ),
        child: IconTheme(
          data: IconThemeData(color: getContentColor(), size: 20),
          child: AnimatedSize(
            duration: 250.ms,
            child: Row(
              mainAxisSize: .min,
              mainAxisAlignment: .center,
              spacing: expanded ? 12 : 8,
              children: [
                if (loading.value)
                  LoadingIndicator(indicatorColor: getContentColor())
                else if (leading != null)
                  leading!,
                Text(label, style: context.text.labelLarge?.textColor(getContentColor()), overflow: .ellipsis),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
