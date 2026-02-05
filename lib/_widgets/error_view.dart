import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ErrorView extends HookConsumerWidget {
  const ErrorView(this.e, this.st, {super.key, this.prov = const [], this.reload});

  final Object e;
  final StackTrace? st;
  final List<ProviderOrFamily> prov;
  final Future Function()? reload;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        const Icon(Icons.warning_amber_rounded, size: 50).clickable(onTap: () => catErr(runtimeType.toString(), e, st)),
        const Gap(Insets.lg),
        Text('Something went wrong', style: context.text.titleMedium, maxLines: 1),
        if (kDebugMode)
          Text(e.toString(), maxLines: 2, textAlign: TextAlign.center)
        else
          Text('Please try again', style: context.text.bodyLarge, maxLines: 1),
        const Gap(Insets.xl),
        if (prov.isNotEmpty)
          OutlinedButton(
            onPressed: () async {
              for (final p in prov) {
                ref.invalidate(p);
              }
              await reload?.call();
            },
            child: const Text('Try again'),
          ),
      ],
    );
  }
}
