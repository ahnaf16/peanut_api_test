import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: const SingleChildScrollView(child: Column()),
    );
  }
}
