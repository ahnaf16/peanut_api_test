import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: Pads.med(),
        child: Column(
          children: [
            Gap(context.padding.top + 6),

            Text('Welcome back', style: context.text.headlineSmall),
            const Gap(10),
            Text('Sign in to continue', style: context.text.bodyLarge?.medium),
            const Gap(20),

            const KTextField(
              title: 'Login Code',
              hintText: 'Enter your login code',
              prefixIcon: Icon(LIcon.notebook),
              keyboardType: TextInputType.number,
            ),
            const Gap(Insets.med),
            const KTextField(title: 'Password', hintText: 'Enter your password', prefixIcon: Icon(LIcon.lock)),

            SubmitButton(label: 'Sign In', expanded: true, onPressed: (l) {}),

            const Gap(20),
            Text('By signing in, you agree to our Terms & Privacy Policy', style: context.text.bodySmall?.outline),
          ],
        ),
      ),
    );
  }
}
