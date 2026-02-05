import 'package:flutter/material.dart';

import '../_core/extensions/context_extension.dart';
import '../_core/layout/space.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: context.colors.onSurface)),
        Padding(
          padding: Pads.sm(),
          child: Text('Or Continue With', style: TextStyle(color: context.colors.onSurface, fontSize: 14)),
        ),
        Expanded(child: Divider(thickness: 1, color: context.colors.onSurface)),
      ],
    );
  }
}
