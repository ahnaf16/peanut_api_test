import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';

class WelcomeView extends HookConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      wait(() => RPaths.login.push(context), 2000);
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            UImage('assets/logo/logo.png', color: context.colors.onPrimary),

            const Spacer(),

            Text(
              'Locum Marketplace',
              style: context.text.bodyMedium?.textColor(
                context.colors.onPrimary,
              ),
            ),

            const Gap(12),

            CircularProgressIndicator(
              color: context.colors.onPrimary,
              strokeWidth: 3,
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
