import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peanut_api_test/_core/strings/assets.gen.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/user/user_model.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = useState(UserType.locum);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              DecoContainer(height: 250, width: double.infinity, color: context.colors.primary),
              const Expanded(child: DecoContainer(width: double.infinity)),
            ],
          ),
          SizedBox(
            height: context.height,
            child: SingleChildScrollView(
              padding: Pads.med(),
              child: Column(
                children: [
                  Gap(context.padding.top + 6),
                  UImage(Assets.logo.logo.path, fit: BoxFit.contain, height: 40, color: context.colors.onPrimary),
                  const Gap(20),
                  Text('Welcome back', style: context.text.headlineSmall?.bold.textColor(context.colors.onPrimary)),
                  const Gap(10),
                  Text(
                    'Sign in to continue to $kAppName',
                    style: context.text.bodyLarge?.medium.textColor(context.colors.onPrimary),
                  ),
                  const Gap(20),
                  DecoContainer(
                    borderRadius: 16,
                    shadows: [
                      BoxShadow(color: context.colors.shadow.op(.08), blurRadius: 12, offset: const Offset(0, 4)),
                    ],
                    width: double.infinity,
                    color: context.colors.onPrimary,
                    padding: Pads.lg(),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text('I am a', style: context.text.bodyLarge?.textColor(context.colors.inverseSurface)),
                        const Gap(Insets.sm),
                        Row(
                          spacing: Insets.lg,
                          children: [
                            ...UserType.values.map((type) {
                              final selected = selectedType.value == type;
                              return Expanded(
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: selected
                                        ? context.colors.primary
                                        : context.colors.secondaryContainer,
                                    foregroundColor: selected
                                        ? context.colors.onPrimary
                                        : context.colors.onSecondaryContainer,
                                  ),
                                  onPressed: () => selectedType.value = type,
                                  child: Text(type.name.titleCase),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(Insets.xxl),
                  const KTextField(
                    title: 'Email Address',
                    hintText: 'Enter your email address',
                    prefixIcon: Icon(Icons.mail_outline),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(Insets.med),
                  const KTextField(
                    title: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        RPaths.resetPassword.push(context);
                      },
                      child: Text('Forgot Password?', style: context.text.labelMedium?.primary),
                    ),
                  ),
                  const Gap(Insets.sm),
                  SubmitButton(
                    label: 'Sign In',
                    expanded: true,
                    onPressed: (l) {
                      RPaths.authVerification.push(context);
                    },
                  ),
                  const Gap(Insets.med),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Don\'t have an account?  ', style: context.text.bodyMedium),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => RPaths.signUp.push(context),
                          text: 'Sign Up',
                          style: context.text.bodyMedium?.primary,
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Text(
                    'By signing in, you agree to our Terms & Privacy Policy',
                    style: context.text.bodySmall?.outline,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
