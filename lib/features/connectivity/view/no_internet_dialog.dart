import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        icon: const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.redAccent),
        title: const Text('No Internet Connection', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: .min,
          children: [
            const Text(
              "It seems you're offline. Please check your network settings to continue using Peanut.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const Gap(Insets.lg),
            Row(
              spacing: Insets.med,
              mainAxisAlignment: .center,
              children: [
                const LoadingIndicator(size: 18),
                Text('Checking connection...', style: context.text.titleMedium?.regular.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
