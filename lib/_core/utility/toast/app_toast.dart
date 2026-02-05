import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';

class AppToast extends StatelessWidget {
  const AppToast({super.key, required this.event, required this.closer});

  final ToastEvent event;
  final Function() closer;

  @override
  Widget build(BuildContext context) {
    final bgColor = switch (event.type) {
      .success => context.xColors.successContainer,
      .error => context.colors.errorContainer,
      .info => context.colors.primaryContainer,
    };

    final color = switch (event.type) {
      .success => context.xColors.success,
      .error => context.colors.error,
      .info => context.colors.primary,
    };

    return Material(
      color: Colors.transparent,
      type: .transparency,
      child: DecoContainer(
        margin: Pads.med(),
        padding: Pads.sym(12, 8),
        borderWidth: 1,
        borderRadius: 10,
        color: bgColor,
        borderColor: color,
        child: Stack(
          children: [
            Row(
              spacing: Insets.sm,
              crossAxisAlignment: .start,
              children: [
                Icon(
                  switch (event.type) {
                    .success => Icons.check_circle,
                    .error => Icons.error_outline_rounded,
                    .info => Icons.info_outline_rounded,
                  },
                  size: 20,
                  color: color,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    spacing: 6,
                    children: [
                      Text(event.title, style: context.text.bodyLarge?.semiBold.textHeight(1).textColor(color)),
                      if (event.message != null)
                        Text(event.message!, style: context.text.labelMedium?.textHeight(1.1).textColor(color)),
                      if (event.actionText != null)
                        GestureDetector(
                          onTap: () {
                            if (event.actionTap != null) {
                              event.actionTap?.call();
                              closer();
                            }
                          },
                          child: DecoContainer(
                            padding: Pads.sym(4, 4).copyWith(left: 0),
                            child: Row(
                              spacing: Insets.sm,
                              children: [
                                Text(event.actionText!, style: context.text.labelMedium?.extraBold.textColor(color)),
                                if (event.actionIcon != null) Icon(event.actionIcon, color: color, size: 16),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: closer,
                child: DecoContainer(
                  padding: Pads.all(8),
                  color: Colors.transparent,
                  child: Icon(Icons.close_rounded, size: 15, color: color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
