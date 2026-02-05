import 'package:flutter/material.dart';

import '../../../main.export.dart';

class ResetPasswordView extends HookConsumerWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: context.colors.primary),
        title: Text(
          'Reset Password',
          style: context.text.titleMedium!.textColor(context.colors.primary),
        ),
      ),
      body: SingleChildScrollView(
        padding: Pads.lg(),
        child: Column(
          children: [
            Text(
              'Please enter your Email Address to reset the password',
              style: context.text.bodyMedium!.textColor(context.colors.primary),
            ),
            const Gap(30),

            const KTextField(
              hintText: 'Enter your email address',
              title: 'Email Address',
              prefixIcon: Icon(LIcon.mail),
            ),
            const Gap(20),
            SubmitButton(
              label: 'Reset Password',
              onPressed: (l) {
                RPaths.checkEmail.push(context);
              },
              expanded: true,
              dense: true,
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
