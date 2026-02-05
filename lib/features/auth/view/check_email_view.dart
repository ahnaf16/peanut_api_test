import 'package:flutter/material.dart';

import '../../../main.export.dart';

class CheckEmailView extends HookConsumerWidget {
  const CheckEmailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: context.colors.primary),
        title: Text('Set new password', style: context.text.titleLarge!.bold.textColor(context.colors.primary)),
      ),
      body: SingleChildScrollView(
        padding: Pads.lg(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Pads.sym(20),
              child: Text(
                'Create a new password. Ensure it differs from previous ones for security',
                textAlign: TextAlign.center,
                style: context.text.bodyMedium!.textColor(context.colors.primary),
              ),
            ),
            const Gap(20),
            const KTextField(
              title: 'New Password',
              hintText: 'Enter your new password',
              prefixIcon: Icon(LIcon.lock),
              isPasswordField: true,
            ),
            const Gap(20),
            const KTextField(
              title: 'Confirm Password',
              hintText: 'Re-enter your Password',
              prefixIcon: Icon(LIcon.lock),
              isPasswordField: true,
            ),
            const Gap(20),
            DecoContainer(
              color: context.colors.surfaceBright,
              width: context.width,
              padding: Pads.lg(),
              borderRadius: 16,
              borderColor: context.colors.outline,
              borderWidth: 1,
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password must contain',
                    style: context.text.bodyLarge?.bold.textColor(context.colors.onSurface),
                  ),
                  const _PasswordValidationTitle(title: 'At least 8 characters'),
                  const _PasswordValidationTitle(title: 'One uppercase letter'),

                  const _PasswordValidationTitle(title: 'At least one number'),
                ],
              ),
            ),
            const Gap(20),
            SubmitButton(
              label: 'Reset Password',
              onPressed: (l) {
                RPaths.resetSuccessful.push(context);
              },
              expanded: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordValidationTitle extends StatelessWidget {
  const _PasswordValidationTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, color: context.colors.outline, size: 18),
        const Gap(10),
        Text(title, style: context.text.bodyMedium?.textColor(context.colors.onSurface)),
      ],
    );
  }
}
